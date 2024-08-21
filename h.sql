-- 1. Criação de Usuários

-- Criação do usuário 'usuario_admin' com senha 'senha_admin'
-- Esse usuário terá permissões administrativas no banco de dados
CREATE USER 'usuario_admin'@'localhost' IDENTIFIED BY 'senha_admin';

-- Criação do usuário 'usuario_leitor' com senha 'senha_leitor'
-- Esse usuário terá permissões limitadas, apenas para leitura
CREATE USER 'usuario_leitor'@'localhost' IDENTIFIED BY 'senha_leitor';

-- 2. Concessão de Permissões

-- Concede todas as permissões no banco de dados 'Pokedex' ao usuário 'usuario_admin'
-- Isso inclui a capacidade de SELECT, INSERT, UPDATE, DELETE, e outras operações administrativas
GRANT ALL PRIVILEGES ON Pokedex.* TO 'usuario_admin'@'localhost';

-- Concede permissões de seleção (leitura) no banco de dados 'Pokedex' ao usuário 'usuario_leitor'
-- O usuário pode realizar operações de leitura (SELECT) nas tabelas
GRANT SELECT ON Pokedex.* TO 'usuario_leitor'@'localhost';

-- 3. Revogação de Permissões

-- Revoga todas as permissões do banco de dados 'Pokedex' do usuário 'usuario_admin'
-- Isso remove todas as permissões administrativas anteriormente concedidas
REVOKE ALL PRIVILEGES ON Pokedex.* FROM 'usuario_admin'@'localhost';

-- Revoga permissões de seleção (leitura) no banco de dados 'Pokedex' do usuário 'usuario_leitor'
-- O usuário não poderá mais realizar operações de leitura nas tabelas
REVOKE SELECT ON Pokedex.* FROM 'usuario_leitor'@'localhost';

-- 4. Aplicar as Mudanças

-- Atualiza os privilégios para garantir que as mudanças sejam aplicadas
-- Isso faz com que todas as concessões e revogações de permissões se tornem efetivas
FLUSH PRIVILEGES;
