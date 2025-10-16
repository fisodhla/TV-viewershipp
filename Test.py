import sqlite3

# Connect to (or create) a database file
conn = sqlite3.connect('answers.db')

# Create a cursor object to execute SQL commands
cursor = conn.cursor()

# Create a table to store answers
cursor.execute('''
CREATE TABLE IF NOT EXISTS answers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT,
    question TEXT,
    answer TEXT
)
''')

conn.commit()
conn.close()