  -- 1. Tabela de log para registrar inserções na tabela `Pokemon`
CREATE TABLE IF NOT EXISTS Pokemon_Insercao_Log (
    id INT NOT NULL AUTO_INCREMENT,  -- Identificador único para cada registro de log
    Pokemon_idPokemon INT NOT NULL,  -- ID do Pokémon inserido
    Nome VARCHAR(40) NOT NULL,  -- Nome do Pokémon inserido
    Data_Insercao DATETIME NOT NULL,  -- Data e hora da inserção
    PRIMARY KEY (id)  -- Chave primária que garante a unicidade dos registros
);

-- 2. Tabela de log para registrar atualizações de status na tabela `Status`
CREATE TABLE IF NOT EXISTS Status_Atualizacao_Log (
    id INT NOT NULL AUTO_INCREMENT,  -- Identificador único para cada registro de log
    Pokemon_idPokemon INT NOT NULL,  -- ID do Pokémon cujo status foi atualizado
    Data_Hora_Atualizacao DATETIME NOT NULL,  -- Data e hora da atualização
    PRIMARY KEY (id)  -- Chave primária que garante a unicidade dos registros
);

-- 3. Tabela de log para registrar exclusões na tabela `Pokemon`
CREATE TABLE IF NOT EXISTS Pokemon_Exclusao_Log (
    id INT NOT NULL AUTO_INCREMENT,  -- Identificador único para cada registro de log
    Pokemon_idPokemon INT NOT NULL,  -- ID do Pokémon excluído
    Nome VARCHAR(40) NOT NULL,  -- Nome do Pokémon excluído
    Data_Exclusao DATETIME NOT NULL,  -- Data e hora da exclusão
    PRIMARY KEY (id)  -- Chave primária que garante a unicidade dos registros
);

-- Agora vamos criar os triggers.

DELIMITER //

-- 1. Trigger para registrar inserções na tabela `Pokemon`
CREATE TRIGGER trg_AposInserirPokemon
AFTER INSERT ON Pokemon
FOR EACH ROW
BEGIN
    -- Este trigger é acionado após a inserção de um novo Pokémon na tabela `Pokemon`.
    -- Ele insere um registro na tabela `Pokemon_Insercao_Log` para manter um log da inserção.
    INSERT INTO Pokemon_Insercao_Log (Pokemon_idPokemon, Nome, Data_Insercao)
    VALUES (NEW.idPokemon, NEW.nome, NOW());  -- `NEW` refere-se à nova linha inserida na tabela `Pokemon`
END //

-- 2. Trigger para registrar atualizações de status na tabela `Status`
CREATE TRIGGER trg_AposAtualizarStatus
AFTER UPDATE ON Status
FOR EACH ROW
BEGIN
    -- Este trigger é acionado após uma atualização na tabela `Status`.
    -- Ele insere um registro na tabela `Status_Atualizacao_Log` para manter um log da atualização.
    INSERT INTO Status_Atualizacao_Log (Pokemon_idPokemon, Data_Hora_Atualizacao)
    VALUES (NEW.Pokemon_idPokemon, NOW());  -- `NEW` refere-se à linha atualizada na tabela `Status`
END //

-- 3. Trigger para registrar exclusões na tabela `Pokemon`
CREATE TRIGGER trg_AposExcluirPokemon
AFTER DELETE ON Pokemon
FOR EACH ROW
BEGIN
    -- Este trigger é acionado após a exclusão de um Pokémon da tabela `Pokemon`.
    -- Ele insere um registro na tabela `Pokemon_Exclusao_Log` para manter um log da exclusão.
    INSERT INTO Pokemon_Exclusao_Log (Pokemon_idPokemon, Nome, Data_Exclusao)
    VALUES (OLD.idPokemon, OLD.nome, NOW());  -- `OLD` refere-se à linha excluída da tabela `Pokemon`
END //

DELIMITER ;

-- Agora, vamos mostrar como esses triggers são acionados com exemplos de inserção, atualização e exclusão.

-- 1. Exemplo de inserção que aciona o trigger `trg_AposInserirPokemon`
INSERT INTO Pokemon (nome, Natureza_idNatureza, numPokedex, altura, peso, nivel)
VALUES ('Bulbasaur', 1, 1, 0.7, 6.9, 5);  -- Isso acionará o trigger para registrar a inserção do Pokémon Bulbasaur.

-- 2. Exemplo de atualização que aciona o trigger `trg_AposAtualizarStatus`
UPDATE Status
SET vida = 95
WHERE Pokemon_idPokemon = 1 AND dataHoraAtualizacao = '2024-08-20 10:00:00';  -- Isso acionará o trigger para registrar a atualização do status do Pokémon com ID 1.

-- 3. Exemplo de exclusão que aciona o trigger `trg_AposExcluirPokemon`
DELETE FROM Pokemon
WHERE idPokemon = 1;  -- Isso acionará o trigger para registrar a exclusão do Pokémon com ID 1.
