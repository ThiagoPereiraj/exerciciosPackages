
CREATE TABLE ALUNO (
    ID_ALUNO NUMBER PRIMARY KEY,
    NOME VARCHAR2(100) NOT NULL,
    DATA_NASCIMENTO DATE NOT NULL,
    ID_CURSO NUMBER NOT NULL
);

CREATE TABLE CURSO (
    ID_CURSO NUMBER PRIMARY KEY,
    NOME_CURSO VARCHAR2(100) NOT NULL
);

CREATE TABLE DISCIPLINA (
    ID_DISCIPLINA NUMBER PRIMARY KEY,
    NOME VARCHAR2(100) NOT NULL,
    DESCRICAO VARCHAR2(255),
    CARGA_HORARIA NUMBER NOT NULL
);

CREATE TABLE PROFESSOR (
    ID_PROFESSOR NUMBER PRIMARY KEY,
    NOME VARCHAR2(100) NOT NULL
);

CREATE TABLE MATRICULA (
    ID_MATRICULA NUMBER PRIMARY KEY,
    ID_ALUNO NUMBER REFERENCES ALUNO(ID_ALUNO),
    ID_DISCIPLINA NUMBER REFERENCES DISCIPLINA(ID_DISCIPLINA)
);

CREATE TABLE TURMA (
    ID_TURMA NUMBER PRIMARY KEY,
    ID_DISCIPLINA NUMBER REFERENCES DISCIPLINA(ID_DISCIPLINA),
    ID_PROFESSOR NUMBER REFERENCES PROFESSOR(ID_PROFESSOR)
);

CREATE SEQUENCE SEQ_ALUNO START WITH 1;
CREATE SEQUENCE SEQ_CURSO START WITH 1;
CREATE SEQUENCE SEQ_DISCIPLINA START WITH 1;
CREATE SEQUENCE SEQ_PROFESSOR START WITH 1;
CREATE SEQUENCE SEQ_MATRICULA START WITH 1;
CREATE SEQUENCE SEQ_TURMA START WITH 1;


-- Inserir cursos
INSERT INTO CURSO (ID_CURSO, NOME_CURSO) VALUES (SEQ_CURSO.NEXTVAL, 'Engenharia da Computação');
INSERT INTO CURSO (ID_CURSO, NOME_CURSO) VALUES (SEQ_CURSO.NEXTVAL, 'Administração');
INSERT INTO CURSO (ID_CURSO, NOME_CURSO) VALUES (SEQ_CURSO.NEXTVAL, 'Direito');

-- Inserir alunos
INSERT INTO ALUNO (ID_ALUNO, NOME, DATA_NASCIMENTO, ID_CURSO) 
VALUES (SEQ_ALUNO.NEXTVAL, 'João Silva', TO_DATE('2000-05-10', 'YYYY-MM-DD'), 1);

INSERT INTO ALUNO (ID_ALUNO, NOME, DATA_NASCIMENTO, ID_CURSO) 
VALUES (SEQ_ALUNO.NEXTVAL, 'Maria Oliveira', TO_DATE('1995-07-22', 'YYYY-MM-DD'), 2);

INSERT INTO ALUNO (ID_ALUNO, NOME, DATA_NASCIMENTO, ID_CURSO) 
VALUES (SEQ_ALUNO.NEXTVAL, 'Carlos Mendes', TO_DATE('2004-03-15', 'YYYY-MM-DD'), 3);

INSERT INTO ALUNO (ID_ALUNO, NOME, DATA_NASCIMENTO, ID_CURSO) 
VALUES (SEQ_ALUNO.NEXTVAL, 'Ana Costa', TO_DATE('1998-12-01', 'YYYY-MM-DD'), 1);

INSERT INTO ALUNO (ID_ALUNO, NOME, DATA_NASCIMENTO, ID_CURSO) 
VALUES (SEQ_ALUNO.NEXTVAL, 'Lucas Pereira', TO_DATE('2003-08-10', 'YYYY-MM-DD'), 2);

-- Inserir disciplinas
INSERT INTO DISCIPLINA (ID_DISCIPLINA, NOME, DESCRICAO, CARGA_HORARIA) 
VALUES (SEQ_DISCIPLINA.NEXTVAL, 'Matemática Discreta', 'Introdução à lógica matemática', 60);

INSERT INTO DISCIPLINA (ID_DISCIPLINA, NOME, DESCRICAO, CARGA_HORARIA) 
VALUES (SEQ_DISCIPLINA.NEXTVAL, 'Administração Financeira', 'Gestão de finanças empresariais', 45);

INSERT INTO DISCIPLINA (ID_DISCIPLINA, NOME, DESCRICAO, CARGA_HORARIA) 
VALUES (SEQ_DISCIPLINA.NEXTVAL, 'Direito Civil', 'Fundamentos do Direito Civil', 90);

-- Inserir professores
INSERT INTO PROFESSOR (ID_PROFESSOR, NOME) 
VALUES (SEQ_PROFESSOR.NEXTVAL, 'Dr. João Pedro');

INSERT INTO PROFESSOR (ID_PROFESSOR, NOME) 
VALUES (SEQ_PROFESSOR.NEXTVAL, 'Profa. Carla Mendes');

INSERT INTO PROFESSOR (ID_PROFESSOR, NOME) 
VALUES (SEQ_PROFESSOR.NEXTVAL, 'Dr. Ricardo Lima');

-- Inserir turmas
INSERT INTO TURMA (ID_TURMA, ID_DISCIPLINA, ID_PROFESSOR) 
VALUES (SEQ_TURMA.NEXTVAL, 1, 1);

INSERT INTO TURMA (ID_TURMA, ID_DISCIPLINA, ID_PROFESSOR) 
VALUES (SEQ_TURMA.NEXTVAL, 2, 2);

INSERT INTO TURMA (ID_TURMA, ID_DISCIPLINA, ID_PROFESSOR) 
VALUES (SEQ_TURMA.NEXTVAL, 3, 3);

-- Inserir matrículas
INSERT INTO MATRICULA (ID_MATRICULA, ID_ALUNO, ID_DISCIPLINA) 
VALUES (SEQ_MATRICULA.NEXTVAL, 1, 1);

INSERT INTO MATRICULA (ID_MATRICULA, ID_ALUNO, ID_DISCIPLINA) 
VALUES (SEQ_MATRICULA.NEXTVAL, 2, 2);

INSERT INTO MATRICULA (ID_MATRICULA, ID_ALUNO, ID_DISCIPLINA) 
VALUES (SEQ_MATRICULA.NEXTVAL, 3, 3);

INSERT INTO MATRICULA (ID_MATRICULA, ID_ALUNO, ID_DISCIPLINA) 
VALUES (SEQ_MATRICULA.NEXTVAL, 4, 1);

INSERT INTO MATRICULA (ID_MATRICULA, ID_ALUNO, ID_DISCIPLINA) 
VALUES (SEQ_MATRICULA.NEXTVAL, 5, 2);

--Pacote Aluno
CREATE OR REPLACE PACKAGE PKG_ALUNO AS
    PROCEDURE EXCLUIR_ALUNO(P_ID_ALUNO NUMBER);
    PROCEDURE LISTAR_ALUNOS_MAIORES18;
    PROCEDURE LISTAR_ALUNOS_POR_CURSO(P_ID_CURSO NUMBER);
END PKG_ALUNO;
/

CREATE OR REPLACE PACKAGE BODY PKG_ALUNO AS
    PROCEDURE EXCLUIR_ALUNO(P_ID_ALUNO NUMBER) IS
    BEGIN
        DELETE FROM MATRICULA WHERE ID_ALUNO = P_ID_ALUNO;
        DELETE FROM ALUNO WHERE ID_ALUNO = P_ID_ALUNO;
    END EXCLUIR_ALUNO;

    PROCEDURE LISTAR_ALUNOS_MAIORES18 IS
        CURSOR C_ALUNOS_MAIORES18 IS
            SELECT NOME, DATA_NASCIMENTO FROM ALUNO
            WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO) / 12) > 18;
    BEGIN
        FOR R IN C_ALUNOS_MAIORES18 LOOP
            DBMS_OUTPUT.PUT_LINE('Nome: ' || R.NOME || ', Data Nascimento: ' || TO_CHAR(R.DATA_NASCIMENTO, 'DD/MM/YYYY'));
        END LOOP;
    END LISTAR_ALUNOS_MAIORES18;

    PROCEDURE LISTAR_ALUNOS_POR_CURSO(P_ID_CURSO NUMBER) IS
        CURSOR C_ALUNOS_CURSO IS
            SELECT NOME FROM ALUNO WHERE ID_CURSO = P_ID_CURSO;
    BEGIN
        FOR R IN C_ALUNOS_CURSO LOOP
            DBMS_OUTPUT.PUT_LINE('Nome: ' || R.NOME);
        END LOOP;
    END LISTAR_ALUNOS_POR_CURSO;
END PKG_ALUNO;
/
--Pacote Disciplina
CREATE OR REPLACE PACKAGE PKG_DISCIPLINA AS
    PROCEDURE CADASTRAR_DISCIPLINA(P_NOME VARCHAR2, P_DESCRICAO VARCHAR2, P_CARGA_HORARIA NUMBER);
    PROCEDURE TOTAL_ALUNOS_POR_DISCIPLINA;
    PROCEDURE MEDIA_IDADE_POR_DISCIPLINA(P_ID_DISCIPLINA NUMBER);
    PROCEDURE LISTAR_ALUNOS_DA_DISCIPLINA(P_ID_DISCIPLINA NUMBER);
END PKG_DISCIPLINA;
/
CREATE OR REPLACE PACKAGE BODY PKG_DISCIPLINA AS
    -- Procedimento para cadastrar uma nova disciplina
    PROCEDURE CADASTRAR_DISCIPLINA(P_NOME VARCHAR2, P_DESCRICAO VARCHAR2, P_CARGA_HORARIA NUMBER) IS
    BEGIN
        INSERT INTO DISCIPLINA (ID_DISCIPLINA, NOME, DESCRICAO, CARGA_HORARIA)
        VALUES (SEQ_DISCIPLINA.NEXTVAL, P_NOME, P_DESCRICAO, P_CARGA_HORARIA);
    END CADASTRAR_DISCIPLINA;

    -- Procedimento para listar o total de alunos por disciplina
    PROCEDURE TOTAL_ALUNOS_POR_DISCIPLINA IS
        CURSOR C_TOTAL_ALUNOS IS
            SELECT D.NOME AS NOME_DISCIPLINA, COUNT(M.ID_ALUNO) AS TOTAL_ALUNOS
            FROM DISCIPLINA D
            JOIN MATRICULA M ON D.ID_DISCIPLINA = M.ID_DISCIPLINA
            GROUP BY D.NOME
            HAVING COUNT(M.ID_ALUNO) > 0;
    BEGIN
        FOR R IN C_TOTAL_ALUNOS LOOP
            DBMS_OUTPUT.PUT_LINE('Disciplina: ' || R.NOME_DISCIPLINA || ', Total de Alunos: ' || R.TOTAL_ALUNOS);
        END LOOP;
    END TOTAL_ALUNOS_POR_DISCIPLINA;

    -- Procedimento para calcular a média de idade dos alunos por disciplina
    PROCEDURE MEDIA_IDADE_POR_DISCIPLINA(P_ID_DISCIPLINA NUMBER) IS
        V_MEDIA_IDADE NUMBER;
    BEGIN
        SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, A.DATA_NASCIMENTO) / 12))
        INTO V_MEDIA_IDADE
        FROM ALUNO A
        JOIN MATRICULA M ON A.ID_ALUNO = M.ID_ALUNO
        WHERE M.ID_DISCIPLINA = P_ID_DISCIPLINA;

        DBMS_OUTPUT.PUT_LINE('Média de Idade dos Alunos na Disciplina: ' || V_MEDIA_IDADE);
    END MEDIA_IDADE_POR_DISCIPLINA;

    -- Procedimento para listar os alunos de uma disciplina
    PROCEDURE LISTAR_ALUNOS_DA_DISCIPLINA(P_ID_DISCIPLINA NUMBER) IS
        CURSOR C_ALUNOS IS
            SELECT A.NOME
            FROM ALUNO A
            JOIN MATRICULA M ON A.ID_ALUNO = M.ID_ALUNO
            WHERE M.ID_DISCIPLINA = P_ID_DISCIPLINA;
    BEGIN
        FOR R IN C_ALUNOS LOOP
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || R.NOME);
        END LOOP;
    END LISTAR_ALUNOS_DA_DISCIPLINA;
END PKG_DISCIPLINA;
/

--Pacote Professor
CREATE OR REPLACE PACKAGE PKG_PROFESSOR AS
    -- Tipo de registro para armazenar dados do cursor
    TYPE TOTAL_TURMAS_REC IS RECORD (
        NOME_PROFESSOR VARCHAR2(100),
        TOTAL_TURMAS NUMBER
    );

    -- Cursor para total de turmas por professor
    CURSOR TOTAL_TURMAS_POR_PROFESSOR RETURN TOTAL_TURMAS_REC;

    -- Function para total de turmas de um professor
    FUNCTION TOTAL_TURMAS_POR_PROF(P_ID_PROFESSOR NUMBER) RETURN NUMBER;

    -- Function para professor de uma disciplina
    FUNCTION PROFESSOR_DA_DISCIPLINA(P_ID_DISCIPLINA NUMBER) RETURN VARCHAR2;
END PKG_PROFESSOR;
/

CREATE OR REPLACE PACKAGE BODY PKG_PROFESSOR AS
    -- Cursor para total de turmas por professor
    CURSOR TOTAL_TURMAS_POR_PROFESSOR RETURN TOTAL_TURMAS_REC IS
        SELECT P.NOME AS NOME_PROFESSOR, COUNT(T.ID_TURMA) AS TOTAL_TURMAS
        FROM PROFESSOR P
        JOIN TURMA T ON P.ID_PROFESSOR = T.ID_PROFESSOR
        GROUP BY P.NOME
        HAVING COUNT(T.ID_TURMA) >= 1;

    -- Function para total de turmas de um professor
    FUNCTION TOTAL_TURMAS_POR_PROF(P_ID_PROFESSOR NUMBER) RETURN NUMBER IS
        V_TOTAL NUMBER;
    BEGIN
        SELECT COUNT(*) INTO V_TOTAL
        FROM TURMA
        WHERE ID_PROFESSOR = P_ID_PROFESSOR;

        RETURN V_TOTAL;
    END TOTAL_TURMAS_POR_PROF;

    -- Function para professor de uma disciplina
    FUNCTION PROFESSOR_DA_DISCIPLINA(P_ID_DISCIPLINA NUMBER) RETURN VARCHAR2 IS
        V_NOME_PROFESSOR VARCHAR2(100);
    BEGIN
        SELECT P.NOME INTO V_NOME_PROFESSOR
        FROM PROFESSOR P
        JOIN TURMA T ON P.ID_PROFESSOR = T.ID_PROFESSOR
        WHERE T.ID_DISCIPLINA = P_ID_DISCIPLINA;

        RETURN V_NOME_PROFESSOR;
    END PROFESSOR_DA_DISCIPLINA;
END PKG_PROFESSOR;
/




