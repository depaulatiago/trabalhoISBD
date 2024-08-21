DELIMITER //

-- 1. Criação do procedimento `sp_InserirPokemon`
CREATE PROCEDURE sp_InserirPokemon(
    IN p_Nome VARCHAR(40),          -- Nome do Pokémon a ser inserido
    IN p_Natureza_idNatureza INT,   -- ID da natureza do Pokémon
    IN p_numPokedex INT,            -- Número da Pokédex do Pokémon
    IN p_altura FLOAT,              -- Altura do Pokémon
    IN p_peso FLOAT,                -- Peso do Pokémon
    IN p_nivel INT                  -- Nível do Pokémon
)
BEGIN
    -- Inserção de dados na tabela `Pokemon`
    INSERT INTO Pokemon (nome, Natureza_idNatureza, numPokedex, altura, peso, nivel)
    VALUES (p_Nome, p_Natureza_idNatureza, p_numPokedex, p_altura, p_peso, p_nivel);

    -- Verificação da inserção com SELECT
    IF ROW_COUNT() > 0 THEN
        SELECT 'Inserção bem-sucedida!' AS Resultado;  -- Mensagem indicando sucesso
    ELSE
        SELECT 'Falha na inserção.' AS Resultado;       -- Mensagem indicando falha
    END IF;
END //

DELIMITER ;

-- Executa o procedimento `sp_InserirPokemon` para adicionar um novo Pokémon
CALL sp_InserirPokemon('Pikachu', 1, 25, 0.4, 6.0, 5);

DELIMITER //

-- 2. Criação da função `fn_CalcularMediaAltura`
CREATE FUNCTION fn_CalcularMediaAltura(p_numPokedex INT)
RETURNS FLOAT                       -- Retorna um valor do tipo FLOAT
DETERMINISTIC                       -- A função sempre retorna o mesmo resultado para os mesmos parâmetros
BEGIN
    DECLARE v_mediaAltura FLOAT;     -- Declara uma variável para armazenar a média de altura

    -- Cálculo da média de altura
    SELECT AVG(altura) INTO v_mediaAltura
    FROM Pokemon
    WHERE numPokedex = p_numPokedex;

    RETURN v_mediaAltura;            -- Retorna a média de altura calculada
END //

DELIMITER ;

-- Executa a função `fn_CalcularMediaAltura` para obter a média de altura do Pokémon com número 25
SELECT fn_CalcularMediaAltura(25) AS MediaAltura;

DELIMITER //

-- 3. Criação do procedimento `sp_AtualizarStatusPokemon`
CREATE PROCEDURE sp_AtualizarStatusPokemon(
    IN p_Pokemon_idPokemon INT,                -- ID do Pokémon a ser atualizado
    IN p_dataHoraAtualizacao DATETIME,         -- Data e hora da atualização
    IN p_vida INT,                            -- Valor da vida do Pokémon
    IN p_ataque INT,                          -- Valor do ataque do Pokémon
    IN p_defesa INT,                          -- Valor da defesa do Pokémon
    IN p_defesaEspecial INT,                  -- Valor da defesa especial do Pokémon
    IN p_ataqueEspecial INT,                  -- Valor do ataque especial do Pokémon
    IN p_velocidade INT                       -- Valor da velocidade do Pokémon
)
BEGIN
    -- Atualiza o status do Pokémon na tabela `Status`
    UPDATE Status
    SET vida = p_vida,
        ataque = p_ataque,
        defesa = p_defesa,
        defesaEspecial = p_defesaEspecial,
        ataqueEspecial = p_ataqueEspecial,
        velocidade = p_velocidade
    WHERE Pokemon_idPokemon = p_Pokemon_idPokemon
    AND dataHoraAtualizacao = p_dataHoraAtualizacao;

    -- Verificação da atualização com SELECT
    IF ROW_COUNT() > 0 THEN
        SELECT 'Status atualizado com sucesso!' AS Resultado;  -- Mensagem indicando sucesso
    ELSE
        SELECT 'Nenhuma atualização feita.' AS Resultado;       -- Mensagem indicando que nenhuma linha foi atualizada
    END IF;
END //

DELIMITER ;

-- Executa o procedimento `sp_AtualizarStatusPokemon` para atualizar o status do Pokémon com ID 1
CALL sp_AtualizarStatusPokemon(1, '2024-01-01 12:00:00', 100, 50, 50, 40, 60, 70);
