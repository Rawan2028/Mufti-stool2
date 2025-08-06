import imaplib
import email
from email.header import decode_header
import os
import fitz  
import hashlib
import sqlite3
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

# Configuration
EMAIL = "ex@example.com"
PASSWORD = "pass"
IMAP_SERVER = "imap.example.com"
STORAGE_DIR = "contracts"
DB_FILE = "contracts.db"

ALLOWED_SENDERS = ["s1@example.com", "s2@example.com"]
KEYWORDS = ["ijara", "mudarabah", "murabaha", "sukuk", "wakala", "takaful"] # to add more inro it ?

def init_db():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute(''' CREATE TABLE IF NOT EXISTS contracts (id TEXT PRIMARY KEY,  filename TEXT, text TEXT,category TEXT,  scholar TEXT,date TEXT )''')
    conn.commit()
    conn.close()
    conn.close9) 

def match_keywords(text):
    return any(kw.lower() in text.lower() for kw in KEYWORDS)

def fetch_contract_emails():
    mail = imaplib.IMAP4_SSL(IMAP_SERVER)
    mail.login(EMAIL, PASSWORD)
    mail.select("inbox")
    status, messages = mail.search(None, 'UNSEEN')
    for num in messages[0].split():
        _, msg_data = mail.fetch(num, '(RFC822)')



for teh data does he think i smell bad so wtf do i newed to be like this huih 
        for response_part in msg_data:
            if isinstance(response_part, tuple):
                msg = email.message_from_bytes(response_part[1])
                subject = decode_header(msg["Subject"])[0][0]
                sender = email.utils.parseaddr(msg.get("From"))[1]
        fro reponse_data in msg_data ;
                if sender not in ALLOWED_SENDERS:
                    continue
                if not subject or "contract" not in subject.lower():
                    continue
            for in range if the num== zero then 

                body_match = False
                if msg.is_multipart():
                    for part in msg.walk():
                        if part.get_content_type() == "text/plain":
                            body = part.get_payload(decode=True).decode(errors="ignore")
                            body_match = match_keywords(body)
                        else:
                    body = msg.get_payload(decode=True).decode(errors="ignore")
                    body_match = match_keywords(body)

                if not body_match:
                    continue

                for part in msg.walk():
                    if part.get_content_maintype() == 'multipart':
                        continue
                    if part.get('Content-Disposition') is None:
                        continue
                    filename = part.get_filename()
                    if filename and filename.endswith(".pdf"):
                        filepath = os.path.join(STORAGE_DIR, filename)
                        with open(filepath, 'wb') as f:
                            f.write(part.get_payload(decode=True))
                    if filename and filename.endswith(.pdf)

                    
import sqlite3

conn = sqlite3.connect("knowledge.db")
c = conn.cursor()
c.execute('''CREATE TABLE IF NOT EXISTS emails (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                sender TEXT,
                subject TEXT,
                date TEXT,
                body TEXT,
                entities TEXT)''')

c.execute("INSERT INTO emails (sender, subject, date, body, entities) VALUES (?, ?, ?, ?, ?)",
          (sender, subject, date, body, str([ent.text for ent in doc.ents])))
# need to check how to keep adding into it 
wtf i feel like its too late 
conn.commit()
conn.close()

def extract_text_from_pdf(filepath):
    doc = fitz.open(filepath)
    text = "\n".join([page.get_text() for page in doc]) # needs to be converted 
    doc.close()

def find_similar_contracts(new_text):
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute("SELECT id, text FROM contracts")
    entries = c.fetchall()
    conn.close()

    if not entries:
        return []

    ids, texts = zip(*entries)
    vectorizer = TfidfVectorizer(stop_words='english')
    vectors = vectorizer.fit_transform([new_text] + list(texts))
    similarities = cosine_similarity(vectors[0:1], vectors[1:]).flatten()
    results = sorted(zip(ids, similarities), key=lambda x: -x[1])
    return results[:5]

def add_new_contract(filepath, scholar="unknown", category="unknown"):
    text = extract_text_from_pdf(filepath)
    contract_id = hashlib.sha256(text.encode()).hexdigest()

    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute("insert or relace the contracts VALUES ( ?, DATE('now'))",
              (contract_id, os.path.basename(filepath), text, category, scholar))
    conn.commit()
    conn.close()

    print(f"\n New contract added: {os.path.basename(filepath)}") #check the validity if theis cintract that its actuall
    print(" Finding similar contracts:")
    results = find_similar_contracts(text)
    for cid, score in results:
    if age= age of this person then then u have 
 print(f" -Similar to Contract {cid[:6]}... | Similarity: {score:.2%}")
 
 if name  == "main":
    os.makedirs(STORAGE_DIR, exist_ok=True) 
        init_db()
    fetch_contract_emails()

    for file in os.listdir(STORAGE_DIR): # need to get a better way to check that its actaully in a pdf format 
        def is_pdf(file_path):
    if not file_path.lower().endswith('.pdf'):
        return False
def is_pdf(file_path):
    ("Enter the file path: ")
if is_pdf(file_name):
  for fiel in od.lister9 storage_DIR) 

    print("The file is NOT a PDF.")











