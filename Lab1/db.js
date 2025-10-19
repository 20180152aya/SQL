const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');
const path = require('path');
const bcrypt = require('bcrypt');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

const mainDB = {
  host: 'localhost',
  user: 'root',
  password: 'aya_123456'
};

app.get('/api/databases', async (req, res) => {
  try {
    const conn = await mysql.createConnection(mainDB);
    const [rows] = await conn.query('SHOW DATABASES');
    const databases = rows
      .map(r => r.Database)
      .filter(db => !['information_schema', 'mysql', 'performance_schema', 'sys'].includes(db));
    await conn.end();
    res.json(databases);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


app.post('/api/add-database', async (req, res) => {
  const { dbName } = req.body;
  if (!dbName) return res.status(400).json({ error: 'Database name is required' });

  try {
    const conn = await mysql.createConnection(mainDB);
    await conn.query(`CREATE DATABASE ??`, [dbName]);
    await conn.end();
    res.json({ message: `Database "${dbName}" created successfully!` });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.post('/api/add-user', async (req, res) => {
  const { database, username, email, password } = req.body;

  if (!database || !username || !email || !password)
    return res.status(400).json({ error: 'All fields are required.' });

  try {
    const conn = await mysql.createConnection({ ...mainDB, database });
    const createTable = `
      CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(255),
        email VARCHAR(255),
        password VARCHAR(255)
      )
    `;
    await conn.query(createTable);

    const hashedPassword = await bcrypt.hash(password, 10);
    const insertUser = 'INSERT INTO users (username, email, password) VALUES (?, ?, ?)';
    await conn.query(insertUser, [username, email, hashedPassword]);

    await conn.end();
    res.json({ message: `User "${username}" added successfully to ${database}` });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/api/all-users', async (req, res) => {
  try {
    const conn = await mysql.createConnection(mainDB);
    const [rows] = await conn.query('SHOW DATABASES');
    const databases = rows
      .map(r => r.Database)
      .filter(db => !['information_schema', 'mysql', 'performance_schema', 'sys'].includes(db));

    let allUsers = [];

    for (const dbName of databases) {
      const dbConn = await mysql.createConnection({ ...mainDB, database: dbName });
      try {
        const [users] = await dbConn.query('SELECT username, email FROM users');
        users.forEach(u => allUsers.push({ ...u, database: dbName }));
      } catch (e) {
      }
      await dbConn.end();
    }

    res.json(allUsers);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
app.post('/api/add-table', async (req, res) => {
  const { database, tableName } = req.body;

  if (!database || !tableName) {
    return res.status(400).json({ error: 'Database and table name are required.' });
  }

  try {
    const dbConn = await mysql.createConnection({ host: 'localhost', user: 'root', password: 'aya_123456', database });
    const createTableQuery = `
      CREATE TABLE ?? (
        id INT AUTO_INCREMENT PRIMARY KEY
      )
    `;
    await dbConn.query(createTableQuery, [tableName]);
    await dbConn.end();
    res.json({ message: `Table "${tableName}" created successfully in "${database}"` });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});



app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));
