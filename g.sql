-- 1. Criação da visão `vw_Pokemon_Tipos` para mostrar Pokémon e seus tipos
CREATE VIEW vw_Pokemon_Tipos AS
SELECT 
    p.idPokemon,  -- ID do Pokémon
    p.nome AS PokemonNome,  -- Nome do Pokémon
    GROUP_CONCAT(t.nomeTipo) AS Tipos  -- Lista concatenada dos tipos do Pokémon
FROM 
    Pokedex.Pokemon p  -- Tabela de Pokémon
JOIN 
    Pokedex.Deve_Possuir dp ON p.idPokemon = dp.Pokemon_idPokemon  -- Junta com a tabela que associa Pokémon aos tipos
JOIN 
    Pokedex.Tipos t ON dp.Tipos_idTipo = t.idTipo  -- Junta com a tabela de tipos
GROUP BY 
    p.idPokemon, p.nome;  -- Agrupa os resultados pelo ID e nome do Pokémon

-- Uso da visão `vw_Pokemon_Tipos` para ver Pokémon e seus tipos
SELECT * FROM vw_Pokemon_Tipos;
-- Exibe todos os registros da visão `vw_Pokemon_Tipos`, que mostra os Pokémons e seus tipos.

-- 2. Criação da visão `vw_Pokemon_Evolucoes` para mostrar evoluções dos Pokémon
CREATE VIEW vw_Pokemon_Evolucoes AS
SELECT DISTINCT
    p.nome AS PokemonNome,  -- Nome do Pokémon original
    e.nomePokemonEvo AS PokemonEvoNome,  -- Nome do Pokémon que é a evolução
    e.numPokedexEvo,  -- Número na Pokédex do Pokémon evoluído
    f.FormaEvo AS FormaEvolucao  -- Forma de evolução do Pokémon
FROM 
    Pokedex.Pokemon p  -- Tabela de Pokémon
JOIN 
    Pokedex.Evolucao e ON p.numPokedex = e.Pokemon_numPokedex  -- Junta com a tabela de evoluções
JOIN 
    Pokedex.FormaDeEvoluir f ON e.FormaDeEvoluir_idFormaEvo = f.idFormaEvo;  -- Junta com a tabela de formas de evolução

-- Uso da visão `vw_Pokemon_Evolucoes` para ver evoluções dos Pokémon
SELECT * FROM vw_Pokemon_Evolucoes;
-- Exibe todos os registros da visão `vw_Pokemon_Evolucoes`, que mostra as evoluções dos Pokémons.

-- 3. Criação da visão `vw_Pokemon_Movimentos` para mostrar Pokémon e seus movimentos
CREATE VIEW vw_Pokemon_Movimentos AS
SELECT DISTINCT
    p.nome AS PokemonNome,  -- Nome do Pokémon
    m.nome AS MovimentoNome,  -- Nome do movimento
    m.potencia,  -- Potência do movimento
    m.precisao,  -- Precisão do movimento
    m.categoriaDoMovimento  -- Categoria do movimento
FROM 
    Pokedex.Pokemon p  -- Tabela de Pokémon
JOIN 
    Pokedex.Pokemon_Aprende_Movimento_Atraves pam ON p.idPokemon = pam.Pokemon_idPokemon  -- Junta com a tabela que associa Pokémon aos movimentos
JOIN 
    Pokedex.Movimento m ON pam.Movimento_idMovimento = m.idMovimento;  -- Junta com a tabela de movimentos

-- Uso da visão `vw_Pokemon_Movimentos` para ver Pokémon e seus movimentos
SELECT * FROM vw_Pokemon_Movimentos;
-- Exibe todos os registros da visão `vw_Pokemon_Movimentos`, que mostra os movimentos dos Pokémons.

-- Remover a visão `vw_Pokemon_Evolucoes`
-- Comentei o comando de remoção da visão `vw_Pokemon_Evolucoes` já que ele foi mencionado, mas não foi fornecido no código. 
-- Caso queira remover, utilize:
-- DROP VIEW IF EXISTS vw_Pokemon_Evolucoes;
