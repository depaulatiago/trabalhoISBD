-- Adiciona uma nova coluna `dataCaptura` à tabela `Pokemon` para armazenar a data de captura dos Pokémon.
-- O tipo da coluna é DATE e permite valores nulos por padrão.
ALTER TABLE `Pokemon`
ADD COLUMN `dataCaptura` DATE DEFAULT NULL;

-- Modifica a coluna `nomeTipo` na tabela `Tipos` para garantir que não permita valores nulos.
-- Além disso, o tamanho máximo da coluna é definido como 60 caracteres.
ALTER TABLE `Tipos`
MODIFY COLUMN `nomeTipo` VARCHAR(60) NOT NULL;

-- Adiciona uma restrição de unicidade na coluna `nome` da tabela `Movimento`.
-- Isso garante que não existam dois movimentos com o mesmo nome na tabela.
ALTER TABLE `Movimento`
ADD UNIQUE (`nome`);

-- Cria uma nova tabela chamada `TabelaExtra` se ela ainda não existir.
-- A tabela tem duas colunas: `idExtra`, um identificador único que aumenta automaticamente,
-- e `descricao`, que armazena uma descrição com até 100 caracteres.
CREATE TABLE IF NOT EXISTS `TabelaExtra` (
  `idExtra` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idExtra`)
) ENGINE = InnoDB;

-- Remove a tabela `TabelaExtra` se ela existir.
-- Isso é útil para limpar a tabela antes de criar uma nova ou realizar outra operação.
DROP TABLE IF EXISTS `TabelaExtra`;
