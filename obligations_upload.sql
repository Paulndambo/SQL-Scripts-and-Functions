DROP TABLE IF EXISTS obligations_import;
CREATE TABLE obligations_import (
	import_id serial PRIMARY KEY,
	identification_number VARCHAR ( 250 ) NOT NULL,
    identification_method INT NOT NULL CHECK (identification_method >= 0 and identification_method <= 1),
	credit_reference VARCHAR(255) NOT NULL,
	creditor_name VARCHAR(255) NOT NULL,
	obligation_type VARCHAR ( 255 ) NOT NULL,
    original_balance DECIMAL NOT NULL, 
    insurance_premium DECIMAL NOT NULL,
	proposed_term INT NOT NULL,
    proposal_installment INT NOT NULL,
    inception_date DATE NOT NULL,
);

do $$
declare
	_obligation_record record;
	
begin
FOR _obligation_record in select * from obligation_import
    LOOP
        INSERT INTO prices_obligation(created,modified,creditor_name,credit_reference,proposal_instalment,original_balance,insurance_premium,inception_date,obligation_type,profile_id,proposed_term)
		VALUES (now(), now(), _obligation_record.creditor_name, _obligation_record.credit_reference, _obligation_record.proposal_installment, _obligation_record.original_balance, _obligation_record.insurance_premium, _obligation_record.inception_date, _obligation_record.obligation_type, get_profile(_obligation_record.identification_number), _obligation_record.proposed_term);


    END LOOP;
end; $$