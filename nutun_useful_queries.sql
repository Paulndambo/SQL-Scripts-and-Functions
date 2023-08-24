-- creating schemes
-- retail schemes
INSERT INTO schemes_scheme (created,modified,name,config,master_policy,max_amount_of_members,policy_number_starting_counter,is_group_scheme)
VALUES (CURRENT_DATE,CURRENT_DATE,'Retail Scheme','{
  "rider_table": false,
  "scheme_type": "retail",
  "policy_number_prefix": "NUTUN"
}',false,1,0,false)

-- Group scheme
INSERT INTO schemes_scheme (created,modified,name,config,master_policy,max_amount_of_members,policy_number_starting_counter,is_group_scheme)
VALUES (CURRENT_DATE,CURRENT_DATE,'Group Scheme','{
  "rider_table": false,
  "scheme_type": "group",
  "policy_number_prefix": "NUTUN"
}',false,10000,0,true)


-- create synergy scheme group
INSERT INTO schemes_schemegroup (created,modified,scheme_id,description,name,payment_method,period_frequency,period_type,pricing_group,cycle_type) 
VALUES (now(),now(),2,'','Synergy','debit_order',1,'MONTH','Synergy','MEMBER_CYCLE')


--  update import column, i.e update id number column
do
$$
declare
    r record;
	newval Text;
begin
    for r in select * from member_import where LENGTH(member_import_identification_number) < 13 AND member_import_identification_method = 1
    loop
		newval := CONCAT('0',r.member_import_identification_number);
		update member_import set member_import_identification_number = newval where member_import_id = r.member_import_id;
		raise notice 'new number is %', newval;
    end loop;
end;
$$