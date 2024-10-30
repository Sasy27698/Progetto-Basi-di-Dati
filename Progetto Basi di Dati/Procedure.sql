--1)PROCEDURA PER CREARE UNA NUOVA TRANSAZIONE
CREATE OR REPLACE PROCEDURE PROCEDURE_CREA_TRANSAZIONE(cod_contoin VARCHAR2 ,modalita_transazionein VARCHAR2, modalita_pagamentoin VARCHAR2, polizain VARCHAR2,id_operazionein VARCHAR2)
IS
conto_non_trovato exception;
codice_conto CONTO.COD_CONTO%type;
no_transazione exception;
nuova_transazione OPERAZIONE.TIPO_OPERAZIONE%type;
BEGIN
SELECT COD_CONTO INTO codice_conto FROM CONTO WHERE COD_CONTO=cod_contoin;
if(codice_conto=0)
THEN
raise conto_non_trovato;
ELSE --allora il codice conto è inserito è corretto
DBMS_OUTPUT.PUT_LINE('IL codice conto esiste');
END IF;
SELECT TIPO_OPERAZIONE into nuova_transazione from OPERAZIONE WHERE TIPO_OPERAZIONE='TRANSAZIONE' AND rownum=1;
if(nuova_transazione<>'TRANSAZIONE')
THEN
RAISE no_transazione;
ELSE
DBMS_OUTPUT.PUT_LINE('tipo operazione è transazione');
DBMS_OUTPUT.PUT_LINE(nuova_transazione);
END IF;
insert into OPERAZIONE(FEMAIL_B,FCOD_CONTO,ID_OPERAZIONE,CIFRA,DATA1,TIPO_OPERAZIONE) values('bttgtn72h03d062u@mailstop.it','3','id_operazionein','5000',to_date('10/01/2015','dd/mm/yyyy'),'TRANSAZIONE');
insert into TRANSAZIONE(MODALITA_PAGAMENTO,MODALITA_TRANSAZIONE,POLIZZA,ID_OPERAZIONE2) values(modalita_pagamentoin,modalita_transazionein,polizain,'id_operazionein');
EXCEPTION
WHEN conto_non_trovato THEN
raise_application_error(-20020,'il conto non esiste');
WHEN no_transazione THEN
raise_application_error(-20021,'no transazione');
END;
/
--2)PROCEDURA PER ELIMINARE UN PRESTITO
CREATE OR REPLACE PROCEDURE PROCEDURE_ELIMINA_UN_PRESTITO(cod_contoin VARCHAR2) 
IS 
conto_non_trovato exception; 
codice_conto CONTO.COD_CONTO%type; 
elimina_prestito OPERAZIONE.TIPO_OPERAZIONE%type; 
non_ha_eliminato_prestito exception; 
BEGIN 
SELECT COD_CONTO INTO codice_conto FROM CONTO WHERE COD_CONTO=cod_contoin; 
if(codice_conto=0) 
THEN 
raise conto_non_trovato; 
ELSE --allora il codice conto è inserito è corretto 
DBMS_OUTPUT.PUT_LINE('IL codice conto esiste'); 
END IF; 
SELECT TIPO_OPERAZIONE into elimina_prestito from OPERAZIONE WHERE TIPO_OPERAZIONE='PRESTITO' AND rownum=1; 
if(elimina_prestito<>'PRESTITO') 
THEN 
RAISE non_ha_eliminato_prestito; 
ELSE 
DBMS_OUTPUT.PUT_LINE('tipo operazione è prestito'); 
DELETE FROM PRESTITO WHERE PROVA_GARANZIA='NO'; 
END IF; 
EXCEPTION 
WHEN conto_non_trovato THEN 
raise_application_error(-20022,'il conto non esiste'); 
WHEN non_ha_eliminato_prestito THEN 
raise_application_error(-20023,'non ha eliminato il prestito'); 
END; 
/
--3)PROCEDURA PER AGGIORNARE UN DEPOSITO
CREATE OR REPLACE PROCEDURE PROCEDURE_AGGIORNARE_DEPOSITO(cod_contoin VARCHAR2,servizio_di_cassain VARCHAR2,tipo_depositoin VARCHAR2,id_operazionein VARCHAR2)
IS
conto_non_trovato exception;
codice_conto CONTO.COD_CONTO%type;
aggiornare_deposito OPERAZIONE.TIPO_OPERAZIONE%type;
non_ha_aggiornato exception;
BEGIN
SELECT COD_CONTO INTO codice_conto FROM CONTO WHERE COD_CONTO=cod_contoin;
if(codice_conto=0)
THEN
raise conto_non_trovato;
ELSE --allora il codice conto è inserito è corretto
DBMS_OUTPUT.PUT_LINE('IL codice conto esiste');
END IF;
SELECT TIPO_OPERAZIONE into aggiornare_deposito from OPERAZIONE WHERE TIPO_OPERAZIONE='DEPOSITO' AND rownum=1;
if(aggiornare_deposito<>'DEPOSITO')
THEN
RAISE non_ha_aggiornato;
ELSE
DBMS_OUTPUT.PUT_LINE('tipo operazione è deposito');
UPDATE DEPOSITO SET SERVIZIO_DI_CASSA=servizio_di_cassain, TIPO_DEPOSITO=tipo_depositoin WHERE id_operazionein=ID_OPERAZIONE3;
END IF;
EXCEPTION
WHEN conto_non_trovato THEN
raise_application_error(-20024,'il conto non esiste');
WHEN non_ha_aggiornato THEN
raise_application_error(-20025,'la tabella deposito non è stata aggiornata');
END;
/
--4)PROCEDURA PER AGGIORNARE UNA PUBBLICITA,UN EMAIL DI UNA FILIALE,E IL CONTROLLO DI UN DIPENDENTE
CREATE OR REPLACE PROCEDURE PROCEDURE_AGGIORNARE_PUBBLICITA(num_tessin NUMBER,email_filialein VARCHAR2,nome_pubblicitain VARCHAR2,durata_pubblicitain NUMBER,canale_trasmissionein VARCHAR2)      
IS      
dipendente_non_trovato exception;      
num_tess DIPENDENTE.NUMERO_TESSERINO%type;     
email FILIALE.EMAIL_FILIALE%type;    
filiale_non_trovata exception;    
BEGIN      
SELECT NUMERO_TESSERINO INTO num_tess FROM DIPENDENTE WHERE NUMERO_TESSERINO=num_tessin;      
if(num_tess IS NULL)      
THEN      
raise dipendente_non_trovato;      
ELSE --allora il numero tesserino inserito è corretto      
DBMS_OUTPUT.PUT_LINE('IL dipendente esiste');      
END IF;     
SELECT EMAIL_FILIALE INTO email FROM FILIALE WHERE EMAIL_FILIALE=email_filialein;      
if(email IS NULL)      
THEN      
raise filiale_non_trovata;      
ELSE --allora il codice conto è inserito è corretto      
DBMS_OUTPUT.PUT_LINE('la filiale esiste');      
UPDATE PUBBLICITA SET NOME_PUBBLICITA=nome_pubblicitain, DURATA_PUBBLICITA=durata_pubblicitain, CANALE_TRASMISSIONE=canale_trasmissioneiN WHERE NOME_PUBBLICITA=nome_pubblicitain;   
END IF;   
EXCEPTION      
WHEN dipendente_non_trovato THEN      
raise_application_error(-20026,'il dipendente non esiste');    
WHEN filiale_non_trovata THEN    
raise_application_error(-20027,'la filiale non esiste');    
END;
/
 




 


 




