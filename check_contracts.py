import os
import glob
import json

def tokenize(text):
    return set(text.lower().split())

def jaccard_similarity(set1, set2):
    intersection = set1.intersection(set2)
    union = set1.union(set2)
    return len(intersection) / len(union) if union else 0

def load_contracts():
    contracts = []
    base_path = os.path.join(os.getcwd(), 'old_contracts')
    for filepath in glob.glob(os.path.join(base_path, '*.txt')):
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            contracts.append((os.path.basename(filepath), content))
    return contracts

def find_similar_contracts(new_contract, old_contracts, threshold=0.2):
    new_tokens = tokenize(new_contract)
    results = []
    for filename, old_text in old_contracts:
        old_tokens = tokenize(old_text)
        score = jaccard_similarity(new_tokens, old_tokens)
        if score >= threshold:
            results.append({"filename": filename, "similarity": score, "snippet": old_text[:200]})
    results.sort(key=lambda x: x["similarity"], reverse=True)
    return results

def handler(request):
    try:
        data = request.json()
        new_contract = data.get("new_contract", "")
    except Exception:
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Invalid JSON"})
        }

    if not new_contract:
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Missing 'new_contract' field"})
        }

    old_contracts = load_contracts()
    similar = find_similar_contracts(new_contract, old_contracts)

    return {
        "statusCode": 200,
        "body": json.dumps({"similar_contracts": similar})
}