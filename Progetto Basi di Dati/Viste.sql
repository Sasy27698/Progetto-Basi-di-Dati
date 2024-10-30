--1)CLASSIFICA_bilancio: Permette di visualizzare tutti i bilanci dal più alto

CREATE OR REPLACE VIEW CLASSIFICA_bilancio AS
SELECT COD_CONTO,BILANCIO,EMAIL_C FROM CONTO
JOIN CLIENTE ON FEMAIL_C1=EMAIL_C
order by (BILANCIO) DESC;

--2)Visualizza_contabili_di_una_filiale: Permette di visualizzare tutti i contabili di una filiale

CREATE OR REPLACE VIEW  Visualizza_contabili_di_una_filiale AS
SELECT  NUMERO_TESSERINO,EMAIL_CON,NOME_F FROM CONTABILE
JOIN DIPENDENTE ON EMAIL_D=EMAIL_CON
JOIN FILIALE ON NOME_F=NOME_FILIALE
GROUP BY NUMERO_TESSERINO,EMAIL_CON,NOME_F;

--3)Visualizza_assicuratori_di_una_filiale: Permette di visualizzare tutti gli assicuratori di una filiale
CREATE OR REPLACE VIEW  Visualizza_assicuratori_di_una_filiale AS
SELECT  NUMERO_TESSERINO,EMAIL_ASS,NOME_F FROM CONTABILE
JOIN DIPENDENTE ON EMAIL_D=EMAIL_ASS
JOIN FILIALE ON NOME_F=NOME_FILIALE
GROUP BY NUMERO_TESSERINO,EMAIL_ASS,NOME_F;

--4)Visualizza_gruppo_assistenza_di_una_filiale: Permette di visualizzare tutti gli assicuratori di una filiale

CREATE OR REPLACE VIEW  Visualizza_assicuratori_di_una_filiale AS
SELECT  NUMERO_TESSERINO,EMAIL_ASSI,NOME_F FROM CONTABILE
JOIN DIPENDENTE ON EMAIL_D=EMAIL_ASSI
JOIN FILIALE ON NOME_F=NOME_FILIALE
GROUP BY NUMERO_TESSERINO,EMAIL_ASSI,NOME_F;

--5)Visualizza__di_una_filiale: Permette di visualizzare tutti gli assicuratori di una filiale

CREATE OR REPLACE VIEW  Visualizza_assicuratori_di_una_filiale AS
SELECT  NUMERO_TESSERINO,EMAIL_B,NOME_F FROM CONTABILE
JOIN DIPENDENTE ON EMAIL_D=EMAIL_B
JOIN FILIALE ON NOME_F=NOME_FILIALE
GROUP BY NUMERO_TESSERINO,EMAIL_B,NOME_F;

--6)VIsualizza_redditto_più_basso : Permette di visualizzare il redditto più basso

CREATE OR REPLACE VIEW Visualizza_redditto_più_basso AS 
SELECT REDDITO,BILANCIO FROM CONTO 
JOIN CLIENTE ON FEMAIL_C1=EMAIL_C 
order by REDDITO ASC, BILANCIO ASC;



