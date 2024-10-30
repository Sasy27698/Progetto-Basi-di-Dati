--1)trigger che impedisce all'utente di aggiornare l'email immettendo quella precedente
CREATE OR REPLACE TRIGGER TRIGGER_EMAIL
BEFORE UPDATE of EMAIL on PERSONA
FOR EACH ROW
DECLARE
email_ridondante exception;
BEGIN
IF :old.EMAIL = :new.EMAIL THEN
   raise email_ridondante;
END IF;
EXCEPTION
WHEN email_ridondante THEN
raise_application_error (-20001,'l email inserita è uguale a quella vecchia');
END;
/

--2)Trigger che limita a 5 le richieste di supporto effettuabili da un cliente
CREATE OR REPLACE TRIGGER TRIGGER_MAX_SUPPORTO
BEFORE INSERT ON SUPPORTO
FOR EACH ROW
DECLARE
cont_cliente number(2,0);
troppe_richieste exception;
BEGIN
SELECT count(*) into cont_cliente FROM SUPPORTO
WHERE EMAIL_CLI = :new.EMAIL_CLI; -- Conteggio richieste correlate al cliente
IF cont_cliente>=5 THEN
    raise troppe_richieste;
END IF;
EXCEPTION
WHEN troppe_richieste THEN
    raise_application_error(-20002,'Il cliente ha effettuato troppe richieste di supporto');
END;
/

--3)Trigger che limita a 2 il numero di pubblicità presenti in una filiare
CREATE OR REPLACE TRIGGER TRIGGER_MAX_PUBBLICITA
BEFORE INSERT ON PUBBLICITA
FOR EACH ROW
DECLARE
totale_pubblicita  number(2,0);
troppe_pubblicita  exception;
BEGIN
SELECT count(*) INTO totale_pubblicita FROM PUBBLICITA
WHERE NOME_FI= :new.NOME_FI;
IF totale_pubblicita>=2 THEN
    raise troppe_pubblicita;
END IF;
EXCEPTION
WHEN troppe_pubblicita THEN
    raise_application_error(-20003,'la filiale possiede troppe pubblicita');
END;
/

--4)Trigger per non creare altre row nella tabella prestito quando prova_garanzia ='NO'
CREATE OR REPLACE TRIGGER TRIGGER_prestito
BEFORE INSERT ON PRESTITO
FOR EACH ROW 
DECLARE
prova    char(2);
troppi_soldi    exception;
BEGIN
SELECT PROVA_GARANZIA INTO prova FROM    PRESTITO;
IF    prova='NO'    THEN
    raise troppi_soldi;
END IF;
EXCEPTION
WHEN troppi_soldi THEN
    raise_application_error(-20004,'Impossibile inserire un alto prestisto con prova garanzia NO');
END;
/

--5)Trigger per non arrivare a 100 dipendenti
CREATE OR REPLACE TRIGGER TRIGGER_troppi_dipendenti
BEFORE INSERT ON DIPENDENTE
FOR EACH ROW
DECLARE
cont_dipendenti number(3,0);
troppi_dipendenti exception;
BEGIN
SELECT count(*) INTO cont_dipendenti FROM DIPENDENTE;
IF cont_dipendenti>=100 THEN
    raise troppi_dipendenti;
END IF;
EXCEPTION
WHEN troppi_dipendenti THEN
 raise_application_error(-20005,'Impossibile inserire un alto dipendente');
END;
/

--6)Trigger per il controllo dei debiti, in modo tale da consentire prestito
CREATE OR REPLACE TRIGGER TRIGGER_troppi_debiti_per_creare_conto
BEFORE INSERT ON CONTO
FOR EACH ROW
DECLARE
debiti_di_persona number(5,0);
troppi_debiti exception;
BEGIN
SELECT ADDEBITO INTO debiti_di_persona FROM CONTO
WHERE FEMAIL_C1 = :new.FEMAIL_C1;
IF debiti_di_persona>=10000 THEN
    raise troppi_debiti;
END IF;
EXCEPTION
WHEN troppi_debiti THEN
 raise_application_error(-20006,'Impossibile creare conto, troppi debiti');
END;
/
