INSERT INTO endereco VALUES
(default, 'Rua Barão do Rio Branco', 'Fortaleza', 'Centro', 101),
(default, 'Av. Beira Mar', 'Fortaleza', 'Meireles', 202),
(default, 'Rua Professor Dias da Rocha', 'Fortaleza', 'Aldeota', 303);

INSERT INTO autor VALUES
(default, 'J.K. Rowling'),
(default, 'Suzanne Collins'),
(default, 'Rick Riordan'),
(default, 'Frank Herbert'),
(default, 'Stephen King');

INSERT INTO categoria VALUES
(default, 'Fantasia'),
(default, 'Ficção Científica'),
(default, 'Suspense'),
(default, 'Aventura');

INSERT INTO livro VALUES
(default, 'Harry Potter e a Pedra Filosofal', 1, 1, 1997, default),
(default, 'Harry Potter e as Relíquias da Morte', 1, 1, 2007, default),
(default, 'Jogos Vorazes', 2, 4, 2008, default),
(default, 'Em Chamas', 2, 4, 2009, default),
(default, 'A Esperança', 2, 4, 2010, default),
(default, 'Percy Jackson e o Ladrão de Raios', 3, 1, 2005, default),
(default, 'Percy Jackson e o Mar de Monstros', 3, 1, 2006, default),
(default, 'Duna', 4, 2, 1965, default),
(default, 'It: A Coisa', 5, 3, 1986, default),
(default, 'O Iluminado', 5, 3, 1977, default);

INSERT INTO usuario VALUES
(default, 'Alice Borges', 'alice@hotmail.com', '(85) 912345678', 1),
(default, 'Bruno Mendes', 'bruno@gmail.com', '(88) 987654321', 2),
(default, 'Carla Nunes', 'carla@gmail.com', '(85) 945678901', 3);

INSERT INTO emprestimo VALUES (default, 1, 1, '2025-04-21', '2025-05-21') -- Alice Borges empresta "Harry Potter e a Pedra Filosofal"
