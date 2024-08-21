-- Exclui a natureza da tabela `Natureza` onde o `idNatureza` é igual a 3.
DELETE FROM Natureza
WHERE idNatureza = 3;

-- Exclui o Pokémon da tabela `Pokemon` onde o `idPokemon` é igual a 5.
DELETE FROM Pokemon
WHERE idPokemon = 5;

-- Remove o movimento da tabela `Movimento` onde o `idMovimento` é igual a 10.
DELETE FROM Movimento
WHERE idMovimento = 10;

-- Exclui a forma de evolução da tabela `FormaDeEvoluir` onde o `idFormaEvo` é igual a 2.
DELETE FROM FormaDeEvoluir
WHERE idFormaEvo = 2;

-- Exclui o registro de status do Pokémon na tabela `Status` com `idPokemon` igual a 7
-- e a data e hora de atualização específica '2024-08-20 10:00:00'.
DELETE FROM Status
WHERE Pokemon_idPokemon = 7 AND dataHoraAtualizacao = '2024-08-20 10:00:00';

-- Exclui todos os registros de status associados ao Pokémon com `idPokemon` igual a 8
-- e depois remove o Pokémon da tabela `Pokemon`.
DELETE s, p
FROM Status s
JOIN Pokemon p ON s.Pokemon_idPokemon = p.idPokemon
WHERE p.idPokemon = 8;
