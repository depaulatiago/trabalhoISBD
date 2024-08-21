-- 1. Recupera o nome e a altura de todos os Pokémons.
SELECT nome, altura
FROM Pokemon;
-- Essa consulta retorna os nomes e as alturas de todos os Pokémons registrados na tabela `Pokemon`.

-- 2. Recupera o nome e o peso de todos os Pokémons que pesam mais de 100 kg.
SELECT nome, peso
FROM Pokemon
WHERE peso > 100;
-- Filtra e exibe os Pokémons cujo peso é superior a 100 kg.

-- 3. Recupera todos os movimentos ordenados por precisão, do mais alto para o mais baixo.
SELECT nome, precisao
FROM Movimento
ORDER BY precisao DESC;
-- Lista os movimentos ordenados pela precisão de forma decrescente, exibindo primeiro os mais precisos.

-- 4. Recupera a média de altura dos Pokémons agrupados por Natureza.
SELECT n.nomeNatureza, AVG(p.altura) AS mediaAltura
FROM Pokemon p
JOIN Natureza n ON p.Natureza_idNatureza = n.idNatureza
GROUP BY n.nomeNatureza;
-- Calcula e exibe a altura média dos Pokémons, agrupados por sua natureza.

-- 5. Recupera os nomes e o total de Pokémons agrupados por Natureza, mas apenas para naturezas que têm mais de 5 Pokémons.
SELECT n.nomeNatureza, COUNT(p.idPokemon) AS totalPokemons
FROM Pokemon p
JOIN Natureza n ON p.Natureza_idNatureza = n.idNatureza
GROUP BY n.nomeNatureza
HAVING COUNT(p.idPokemon) > 5;
-- Agrupa os Pokémons por Natureza e mostra apenas as naturezas que possuem mais de 5 Pokémons.

-- 6. Recupera os nomes dos Pokémons e seus respectivos movimentos, incluindo apenas aqueles com precisão maior que 80.
SELECT p.nome AS nomePokemon, m.nome AS nomeMovimento
FROM Pokemon p
JOIN Pokemon_Aprende_Movimento_Atraves pam ON p.idPokemon = pam.Pokemon_idPokemon
JOIN Movimento m ON pam.Movimento_idMovimento = m.idMovimento
WHERE m.precisao > 80;
-- Lista os nomes dos Pokémons e os movimentos que eles aprendem, mas somente aqueles movimentos cuja precisão é maior que 80.

-- 7. Recupera todos os tipos de Pokémons que ainda não possuem nenhum movimento associado.
SELECT t.nomeTipo
FROM Tipos t
LEFT JOIN Movimento m ON t.idTipo = m.Tipos_idTipo
WHERE m.idMovimento IS NULL;
-- Exibe os tipos de Pokémons que não têm nenhum movimento associado.

-- 8. Recupera todos os Pokémons que estão entre os níveis 10 e 20.
SELECT nome, nivel
FROM Pokemon
WHERE nivel BETWEEN 10 AND 20;
-- Lista os Pokémons que estão no intervalo de nível entre 10 e 20, inclusive.

-- 9. Recupera o nome dos Pokémons que possuem o movimento com o ID 5 ou 10.
SELECT p.nome
FROM Pokemon p
JOIN Pokemon_Aprende_Movimento_Atraves pam ON p.idPokemon = pam.Pokemon_idPokemon
WHERE pam.Movimento_idMovimento IN (5, 10);
-- Exibe o nome dos Pokémons que aprenderam os movimentos com IDs 5 ou 10.

-- 10. Recupera o nome dos Pokémons que possuem nível superior ao de todos os Pokémons com natureza "Brava".
SELECT p.nome
FROM Pokemon p
WHERE p.nivel > ALL (
    SELECT p2.nivel
    FROM Pokemon p2
    JOIN Natureza n ON p2.Natureza_idNatureza = n.idNatureza
    WHERE n.nomeNatureza = 'Brava'
);
-- Lista os Pokémons cujo nível é superior ao nível de todos os Pokémons que têm natureza "Brava".

-- 11. Recupera os nomes dos Pokémons que possuem pelo menos um movimento de tipo 'Fogo'.
SELECT p.nome
FROM Pokemon p
WHERE EXISTS (
    SELECT 1
    FROM Pokemon_Aprende_Movimento_Atraves pam
    JOIN Movimento m ON pam.Movimento_idMovimento = m.idMovimento
    JOIN Tipos t ON m.Tipos_idTipo = t.idTipo
    WHERE pam.Pokemon_idPokemon = p.idPokemon
    AND t.nomeTipo = 'Fogo'
);
-- Recupera o nome dos Pokémons que têm pelo menos um movimento do tipo 'Fogo'. A subconsulta verifica a existência desse movimento para cada Pokémon.

-- 12. Recupera o nome e o total de movimentos de cada Pokémon que tem mais de 3 movimentos.
SELECT p.nome, COUNT(m.idMovimento) AS totalMovimentos
FROM Pokemon p
JOIN Pokemon_Aprende_Movimento_Atraves pam ON p.idPokemon = pam.Pokemon_idPokemon
JOIN Movimento m ON pam.Movimento_idMovimento = m.idMovimento
GROUP BY p.nome
HAVING COUNT(m.idMovimento) > 3;
-- Exibe o nome de cada Pokémon e o número total de movimentos que ele aprende, mas apenas para aqueles que têm mais de 3 movimentos.
