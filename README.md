# Sistema Acadêmico com Oracle PL/SQL

Este projeto implementa um sistema acadêmico básico utilizando Oracle PL/SQL. Ele contém scripts para criar tabelas, sequências, dados de exemplo, e pacotes PL/SQL para gerenciar operações comuns.

---

## 📋 Requisitos

- **Banco de Dados**: Oracle Database instalado e configurado.
- **Ferramenta SQL**: SQL Developer, SQL*Plus ou outra interface para execução de scripts.
- **Permissões Necessárias**:
  - Criar tabelas, sequências, pacotes, e inserir dados.

---

## 🛠 Estrutura do Projeto

### 1. **Tabelas Criadas**
As tabelas modelam o sistema acadêmico básico:
- **CURSO**: Cursos disponíveis na instituição.
- **ALUNO**: Alunos matriculados, relacionados a um curso.
- **DISCIPLINA**: Disciplinas disponíveis.
- **PROFESSOR**: Professores responsáveis pelas disciplinas.
- **TURMA**: Turmas que associam professores e disciplinas.
- **MATRICULA**: Alunos matriculados em disciplinas específicas.

### 2. **Sequências**
Cada tabela com chave primária usa uma sequência para geração automática de IDs.

### 3. **Dados de Exemplo**
- Cursos: "Engenharia da Computação", "Administração", "Direito".
- Alunos, professores, disciplinas, turmas e matrículas de exemplo.

### 4. **Pacotes PL/SQL**
Os pacotes encapsulam as principais operações:
- **PKG_ALUNO**: Gerenciamento de alunos.
- **PKG_DISCIPLINA**: Gerenciamento de disciplinas.
- **PKG_PROFESSOR**: Gerenciamento de professores e turmas.

---

## 🚀 Como Executar o Script

### 1. Configurar o Ambiente
- Certifique-se de que o Oracle Database está rodando.
- Conecte-se ao banco de dados com um usuário autorizado.

### 2. Executar
- Clone o repositório
```bash
    git clone https://github.com/ThiagoPereiraj/exerciciosPackages
```

- Importe o script para o SQL Developer

- Execute o script "banco_de_dados.sql" 

  
### 3. Habilitar Saída de Texto
Se estiver usando SQL*Plus ou SQL Developer:
```sql
SET SERVEROUTPUT ON;
