PRAGMA foreign_keys = ON;

CREATE TABLE Participante (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    telefone TEXT
);

CREATE TABLE Evento (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT,
    local TEXT NOT NULL,
    data TEXT NOT NULL
);

CREATE TABLE Inscricao (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_evento INTEGER NOT NULL,
    id_participante INTEGER NOT NULL,
    data_inscricao TEXT,
    status TEXT,
    FOREIGN KEY (id_evento) REFERENCES Evento(id) ON DELETE CASCADE,
    FOREIGN KEY (id_participante) REFERENCES Participante(id) ON DELETE CASCADE
);

CREATE TABLE Pagamento (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_inscricao INTEGER UNIQUE,
    valor REAL,
    data_pagamento TEXT,
    status TEXT,
    FOREIGN KEY (id_inscricao) REFERENCES Inscricao(id) ON DELETE CASCADE
);

INSERT INTO Participante (nome, email, telefone) VALUES
('João Lucas', 'joao.lucas@gmail.com', '34999990001'),
('Valentina', 'valentina@gmail.com', '34999990002'),
('Ana Julia', 'ana.julia@gmail.com', '34999990003');

INSERT INTO Evento (nome, descricao, local, data) VALUES
('Seminário de Tecnologia', 'Palestras sobre tendências em TI', 'Auditório A', '2025-09-10'),
('Workshop de Banco de Dados', 'Oficina prática de modelagem e SQL', 'Laboratório 3', '2025-09-15');

INSERT INTO Inscricao (id_evento, id_participante, data_inscricao, status) VALUES
(1, 1, '2025-08-20', 'confirmada'),
(1, 2, '2025-08-21', 'confirmada'),
(2, 2, '2025-08-25', 'confirmada'),
(2, 3, '2025-08-26', 'pendente');

INSERT INTO Pagamento (id_inscricao, valor, data_pagamento, status) VALUES
(1, 100.00, '2025-08-22', 'pago'),
(2, 100.00, '2025-08-23', 'pago'),
(3, 150.00, '2025-08-26', 'pago'),
(4, 150.00, '2025-08-28', 'pendente');

SELECT p.nome, p.email, e.nome AS evento, i.status AS status_inscricao, pg.status AS status_pagamento
FROM Inscricao i
JOIN Participante p ON i.id_participante = p.id
JOIN Evento e ON i.id_evento = e.id
LEFT JOIN Pagamento pg ON i.id = pg.id_inscricao;
