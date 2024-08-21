-- Desativa as verificações de unicidade de chave e integridade referencial temporariamente
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

-- Define o modo SQL, incluindo restrições de agrupamento e validações de dados
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Cria o esquema 'Pokedex', se não existir
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pokedex` DEFAULT CHARACTER SET utf8 ;
USE `Pokedex` ;  -- Define o esquema Pokedex como o esquema ativo

-- -----------------------------------------------------
-- Tabela 'Natureza': Armazena as naturezas dos Pokémon
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pokedex`.`Natureza` (
  `idNatureza` INT NOT NULL AUTO_INCREMENT,  -- Identificador único para a natureza, gerado automaticamente
  `nomeNatureza` VARCHAR(40) NOT NULL,       -- Nome da natureza, limitado a 40 caracteres
  PRIMARY KEY (`idNatureza`))                -- Define idNatureza como chave primária
ENGINE = InnoDB;                             -- Define o mecanismo de armazenamento como InnoDB, que suporta transações e integridade referencial

-- -----------------------------------------------------
-- Tabela 'Pokemon': Armazena os Pokémon e suas características básicas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pokedex`.`Pokemon` (
  `idPokemon` INT NOT NULL AUTO_INCREMENT,              -- Identificador único do Pokémon, gerado automaticamente
  `Natureza_idNatureza` INT NOT NULL,                   -- Referência à tabela Natureza, para associar uma natureza ao Pokémon
  `numPokedex` INT NOT NULL,                            -- Número do Pokémon na Pokédex
  `nome` VARCHAR(40) NOT NULL,                          -- Nome do Pokémon, limitado a 40 caracteres
  `altura` FLOAT NOT NULL,                              -- Altura do Pokémon
  `peso` FLOAT NOT NULL,                                -- Peso do Pokémon
  `nivel` INT NOT NULL,                                 -- Nível do Pokémon
  PRIMARY KEY (`idPokemon`),                            -- Define idPokemon como chave primária
  INDEX `fk_Pokemon_Natureza1_idx` (`Natureza_idNatureza` ASC) VISIBLE,  -- Cria um índice para a coluna Natureza_idNatureza, melhorando a performance de consultas
  CONSTRAINT `fk_Pokemon_Natureza1`                     -- Define uma chave estrangeira que liga Natureza_idNatureza à coluna idNatureza na tabela Natureza
    FOREIGN KEY (`Natureza_idNatureza`)
    REFERENCES `Pokedex`.`Natureza` (`idNatureza`)
    ON DELETE RESTRICT                                  -- Restringe a exclusão de uma natureza se houver um Pokémon relacionado
    ON UPDATE CASCADE)                                  -- Atualiza automaticamente Natureza_idNatureza se idNatureza for alterado
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela 'Status': Armazena os status dos Pokémon em um determinado momento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pokedex`.`Status` (
  `Pokemon_idPokemon` INT NOT NULL,                    -- Referência ao Pokémon associado a este status
  `dataHoraAtualizacao` DATETIME NOT NULL,             -- Data e hora da atualização do status
  `vida` INT NOT NULL,                                 -- Vida do Pokémon
  `ataque` INT NOT NULL,                               -- Ataque do Pokémon
  `defesa` INT NOT NULL,                               -- Defesa do Pokémon
  `defesaEspecial` INT NOT NULL,                       -- Defesa Especial do Pokémon
  `ataqueEspecial` INT NOT NULL,                       -- Ataque Especial do Pokémon
  `velocidade` INT NOT NULL,                           -- Velocidade do Pokémon
  INDEX `fk_Status_Pokemon1_idx` (`Pokemon_idPokemon` ASC) VISIBLE,  -- Cria um índice para a coluna Pokemon_idPokemon
  PRIMARY KEY (`Pokemon_idPokemon`, `dataHoraAtualizacao`),  -- Define uma chave primária composta por Pokemon_idPokemon e dataHoraAtualizacao
  CONSTRAINT `fk_Status_Pokemon1`                      -- Define uma chave estrangeira que liga Pokemon_idPokemon à coluna idPokemon na tabela Pokemon
    FOREIGN KEY (`Pokemon_idPokemon`)
    REFERENCES `Pokedex`.`Pokemon` (`idPokemon`)
    ON DELETE CASCADE                                  -- Exclui automaticamente os status se o Pokémon associado for deletado
    ON UPDATE CASCADE)                                 -- Atualiza automaticamente Pokemon_idPokemon se idPokemon for alterado
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela 'Tipos': Armazena os diferentes tipos de Pokémon
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pokedex`.`Tipos` (
  `idTipo` INT NOT NULL AUTO_INCREMENT,                -- Identificador único para o tipo, gerado automaticamente
  `nomeTipo` VARCHAR(40) NOT NULL,                     -- Nome do tipo, limitado a 40 caracteres
  PRIMARY KEY (`idTipo`))                              -- Define idTipo como chave primária
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela 'FormaDeEvoluir': Armazena as diferentes formas de evolução dos Pokémon
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pokedex`.`FormaDeEvoluir` (
  `idFormaEvo` INT NOT NULL AUTO_INCREMENT,            -- Identificador único para a forma de evolução, gerado automaticamente
  `FormaEvo` CHAR(1) NOT NULL,                         -- Tipo de forma de evolução (usando um único caractere, ex: 'L' para level, 'S' para stone)
  `nomePedra` VARCHAR(40) NULL,                        -- Nome da pedra usada para evoluir, se aplicável
  `nivelEvoluir` INT NULL,                             -- Nível necessário para evolução, se aplicável
  PRIMARY KEY (`idFormaEvo`))                          -- Define idFormaEvo como chave primária
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela 'Movimento': Armazena os movimentos que um Pokémon pode aprender
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pokedex`.`Movimento` (
  `idMovimento` INT NOT NULL AUTO_INCREMENT,           -- Identificador único para o movimento, gerado automaticamente
  `Tipos_idTipo` INT NOT NULL,                         -- Referência ao tipo do movimento, associando à tabela Tipos
  `nome` VARCHAR(40) NOT NULL,                         -- Nome do movimento, limitado a 40 caracteres
  `potencia` INT NOT NULL,                             -- Potência do movimento
  `precisao` INT NOT NULL,                             -- Precisão do movimento
  `categoriaDoMovimento` CHAR(1) NOT NULL,             -- Categoria do movimento (ex: 'F' para físico, 'E' para especial, 'S' para status)
  `descricao` VARCHAR(200) NOT NULL,                   -- Descrição detalhada do movimento
  PRIMARY KEY (`idMovimento`),                         -- Define idMovimento como chave primária
  INDEX `fk_Movimento_Tipos1_idx` (`Tipos_idTipo` ASC) VISIBLE,  -- Cria um índice para a coluna Tipos_idTipo
  CONSTRAINT `fk_Movimento_Tipos1`                     -- Define uma chave estrangeira que liga Tipos_idTipo à coluna idTipo na tabela Tipos
    FOREIGN KEY (`Tipos_idTipo`)
    REFERENCES `Pokedex`.`Tipos` (`idTipo`)
    ON DELETE RESTRICT                                 -- Restringe a exclusão de um tipo se houver movimentos associados
    ON UPDATE CASCADE)                                 -- Atualiza automaticamente Tipos_idTipo se idTipo for alterado
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela 'FormaDeAprender': Armazena as formas pelas quais um Pokémon pode aprender um movimento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pokedex`.`FormaDeAprender` (
  `idFormaAprender` INT NOT NULL AUTO_INCREMENT,       -- Identificador único para a forma de aprendizado, gerado automaticamente
  `ehTreinador` TINYINT NOT NULL,                      -- Indica se a forma de aprendizado envolve um treinador (1 para sim, 0 para não)
  `nomeTreinador` VARCHAR(40) NULL,                    -- Nome do treinador, se aplicável
  `ehNivel` TINYINT NOT NULL,                          -- Indica se a forma de aprendizado envolve atingir um certo nível (1 para sim, 0 para não)
  `nivelAprender` VARCHAR(40) NULL,                    -- Nível no qual o movimento é aprendido, se aplicável
  `ehDisco` TINYINT NOT NULL,                          -- Indica se a forma de aprendizado envolve o uso de um disco TM/HM (1 para sim, 0 para não)
  `nomeDisco` VARCHAR(40) NULL,                        -- Nome do disco TM/HM, se aplicável
  PRIMARY KEY (`idFormaAprender`))                     -- Define idFormaAprender como chave primária
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela 'Deve_Possuir': Relação muitos-para-muitos entre Pokémon e Tipos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pokedex`.`Deve_Possuir` (
  `Pokemon_idPokemon` INT NOT NULL,                    -- Referência ao Pokémon na relação
  `Tipos_idTipo` INT NOT NULL,                         -- Referência ao tipo na relação
  INDEX `fk_Pokemon_has_Tipos_Tipos1_idx` (`Tipos_idTipo` ASC) VISIBLE,  -- Cria um índice para Tipos_idTipo
  INDEX `fk_Pokemon_has_Tipos_Pokemon1_idx` (`Pokemon_idPokemon` ASC) VISIBLE,  -- Cria um índice para Pokemon_idPokemon
  PRIMARY KEY (`Pokemon_idPokemon`, `Tipos_idTipo`),   -- Define uma chave primária composta por Pokemon_idPokemon e Tipos_idTipo
  CONSTRAINT `fk_Pokemon_has_Tipos_Pokemon1`           -- Define uma chave estrangeira que liga Pokemon_idPokemon à coluna idPokemon na tabela Pokemon
    FOREIGN KEY (`Pokemon_idPokemon`)
    REFERENCES `Pokedex`.`Pokemon` (`idPokemon`)
    ON DELETE CASCADE                                  -- Exclui automaticamente a relação se o Pokémon for deletado
    ON UPDATE CASCADE,                                 -- Atualiza automaticamente Pokemon_idPokemon se idPokemon for alterado
  CONSTRAINT `fk_Pokemon_has_Tipos_Tipos1`             -- Define uma chave estrangeira que liga Tipos_idTipo à coluna idTipo na tabela Tipos
    FOREIGN KEY (`Tipos_idTipo`)
    REFERENCES `Pokedex`.`Tipos` (`idTipo`)
    ON DELETE CASCADE                                  -- Exclui automaticamente a relação se o tipo for deletado
    ON UPDATE CASCADE)                                 -- Atualiza automaticamente Tipos_idTipo se idTipo for alterado
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela 'Evolucao': Armazena os relacionamentos de evolução entre os Pokémon
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pokedex`.`Evolucao` (
  `numPokedexEvo` INT NOT NULL,                        -- Número do Pokémon que está sendo evoluído
  `Pokemon_numPokedex` INT NOT NULL,                   -- Número do Pokémon resultante da evolução
  `FormaDeEvoluir_idFormaEvo` INT NOT NULL,            -- Referência à forma específica de evolução
  INDEX `fk_Evolucao_Pokemon1_idx` (`Pokemon_numPokedex` ASC) VISIBLE,  -- Cria um índice para Pokemon_numPokedex
  INDEX `fk_Evolucao_FormaDeEvoluir1_idx` (`FormaDeEvoluir_idFormaEvo` ASC) VISIBLE,  -- Cria um índice para FormaDeEvoluir_idFormaEvo
  PRIMARY KEY (`numPokedexEvo`, `Pokemon_numPokedex`, `FormaDeEvoluir_idFormaEvo`),  -- Define uma chave primária composta por numPokedexEvo, Pokemon_numPokedex, e FormaDeEvoluir_idFormaEvo
  CONSTRAINT `fk_Evolucao_Pokemon1`                    -- Define uma chave estrangeira que liga Pokemon_numPokedex à coluna idPokemon na tabela Pokemon
    FOREIGN KEY (`Pokemon_numPokedex`)
    REFERENCES `Pokedex`.`Pokemon` (`idPokemon`)
    ON DELETE RESTRICT                                 -- Restringe a exclusão se houver evoluções associadas
    ON UPDATE CASCADE,                                 -- Atualiza automaticamente Pokemon_numPokedex se idPokemon for alterado
  CONSTRAINT `fk_Evolucao_FormaDeEvoluir1`             -- Define uma chave estrangeira que liga FormaDeEvoluir_idFormaEvo à coluna idFormaEvo na tabela FormaDeEvoluir
    FOREIGN KEY (`FormaDeEvoluir_idFormaEvo`)
    REFERENCES `Pokedex`.`FormaDeEvoluir` (`idFormaEvo`)
    ON DELETE RESTRICT                                 -- Restringe a exclusão se houver evoluções associadas
    ON UPDATE CASCADE)                                 -- Atualiza automaticamente FormaDeEvoluir_idFormaEvo se idFormaEvo for alterado
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela 'Aprender': Relaciona Pokémon, movimentos e a forma como esses movimentos são aprendidos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pokedex`.`Aprender` (
  `Pokemon_idPokemon` INT NOT NULL,                    -- Referência ao Pokémon que aprende o movimento
  `Movimento_idMovimento` INT NOT NULL,                -- Referência ao movimento que é aprendido
  `FormaDeAprender_idFormaAprender` INT NOT NULL,      -- Referência à forma de aprendizado do movimento
  INDEX `fk_Pokemon_has_Movimento_Movimento1_idx` (`Movimento_idMovimento` ASC) VISIBLE,  -- Cria um índice para Movimento_idMovimento
  INDEX `fk_Pokemon_has_Movimento_Pokemon1_idx` (`Pokemon_idPokemon` ASC) VISIBLE,  -- Cria um índice para Pokemon_idPokemon
  INDEX `fk_Pokemon_has_Movimento_FormaDeAprender1_idx` (`FormaDeAprender_idFormaAprender` ASC) VISIBLE,  -- Cria um índice para FormaDeAprender_idFormaAprender
  PRIMARY KEY (`Pokemon_idPokemon`, `Movimento_idMovimento`, `FormaDeAprender_idFormaAprender`),  -- Define uma chave primária composta por Pokemon_idPokemon, Movimento_idMovimento, e FormaDeAprender_idFormaAprender
  CONSTRAINT `fk_Pokemon_has_Movimento_Pokemon1`       -- Define uma chave estrangeira que liga Pokemon_idPokemon à coluna idPokemon na tabela Pokemon
    FOREIGN KEY (`Pokemon_idPokemon`)
    REFERENCES `Pokedex`.`Pokemon` (`idPokemon`)
    ON DELETE RESTRICT                                 -- Restringe a exclusão se houver associações a movimentos
    ON UPDATE CASCADE,                                 -- Atualiza automaticamente Pokemon_idPokemon se idPokemon for alterado
  CONSTRAINT `fk_Pokemon_has_Movimento_Movimento1`     -- Define uma chave estrangeira que liga Movimento_idMovimento à coluna idMovimento na tabela Movimento
    FOREIGN KEY (`Movimento_idMovimento`)
    REFERENCES `Pokedex`.`Movimento` (`idMovimento`)
    ON DELETE RESTRICT                                 -- Restringe a exclusão se houver associações a Pokémon
    ON UPDATE CASCADE,                                 -- Atualiza automaticamente Movimento_idMovimento se idMovimento for alterado
  CONSTRAINT `fk_Pokemon_has_Movimento_FormaDeAprender1`  -- Define uma chave estrangeira que liga FormaDeAprender_idFormaAprender à coluna idFormaAprender na tabela FormaDeAprender
    FOREIGN KEY (`FormaDeAprender_idFormaAprender`)
    REFERENCES `Pokedex`.`FormaDeAprender` (`idFormaAprender`)
    ON DELETE RESTRICT                                 -- Restringe a exclusão se houver associações a formas de aprendizado
    ON UPDATE CASCADE)                                 -- Atualiza automaticamente FormaDeAprender_idFormaAprender se idFormaAprender for alterado
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Reativa as verificações de unicidade de chave e integridade referencial
-- -----------------------------------------------------
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
