-- Atualiza o nome da natureza para 'Brava' na tabela `Natureza` onde o `idNatureza` é igual a 1.
UPDATE Natureza
SET nomeNatureza = 'Brava'
WHERE idNatureza = 1;

-- Altera o nome do Pokémon para 'Pikachu' e seu nível para 25 na tabela `Pokemon`
-- onde o `idPokemon` é igual a 2.
UPDATE Pokemon
SET nome = 'Pikachu', nivel = 25
WHERE idPokemon = 2;

-- Define a potência como 90 e a precisão como 100 no movimento da tabela `Movimento`
-- onde o `idMovimento` é igual a 5.
UPDATE Movimento
SET potencia = 90, precisao = 100
WHERE idMovimento = 5;

-- Atualiza o nível necessário para evoluir para 36 na tabela `FormaDeEvoluir`
-- onde o `idFormaEvo` é igual a 3.
UPDATE FormaDeEvoluir
SET nivelEvoluir = 36
WHERE idFormaEvo = 3;

-- Atualiza a vida para 120 e o ataque para 80 na tabela `Status` para o Pokémon
-- com `idPokemon` igual a 4 e onde a data e hora de atualização é '2024-08-20 10:00:00'.
UPDATE Status
SET vida = 120, ataque = 80
WHERE Pokemon_idPokemon = 4 AND dataHoraAtualizacao = '2024-08-20 10:00:00';

-- Atualiza o nível do Pokémon para 50 e o nome do treinador para 'Ash Ketchum'.
-- A atualização é realizada para Pokémon com vida superior a 100 e que estão sendo treinados por um treinador.
UPDATE Pokemon p
JOIN Status s ON p.idPokemon = s.Pokemon_idPokemon
JOIN Pokemon_Aprende_Movimento_Atraves pam ON p.idPokemon = pam.Pokemon_idPokemon
JOIN FormaDeAprender fda ON pam.FormaDeAprender_idFormaAprender = fda.idFormaAprender
SET p.nivel = 50, fda.nomeTreinador = 'Ash Ketchum'
WHERE s.vida > 100 AND fda.ehTreinador = 1;
