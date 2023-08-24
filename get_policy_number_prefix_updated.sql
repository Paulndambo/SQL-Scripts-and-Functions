create or replace function get_policy_number_prefix_updated(_pricing_id int)
returns text
language plpgsql
as
$$
declare
   _policy_number_prefix text;
begin
	if _pricing_id = 0 then
	  _policy_number_prefix := 'SYN_';
	elsif _pricing_id = 6 then
	  _policy_number_prefix := 'NMBD_';
	elsif _pricing_id = 9 then
		_policy_number_prefix := 'NKL_';
	elsif _pricing_id = 7 then 
		_policy_number_prefix := 'NBSL_';
	elsif _pricing_id = 5 then
		_policy_number_prefix := 'NMBL_';
	elsif _pricing_id = 3 then
		_policy_number_prefix := 'NWL_';
	elsif _pricing_id = 4 then
		_policy_number_prefix := 'NTL_';
    elsif _pricing_id = 1 then
		_policy_number_prefix := 'NW_';
    elsif _pricing_id = 2 then
		_policy_number_prefix := 'MBD_';
	elsif _pricing_id = 10 then
		_policy_number_prefix := 'NTLG_';
	elsif _pricing_id = 11 then
		_policy_number_prefix := 'NWLG_';
	elsif _pricing_id = 12 then
		_policy_number_prefix := 'NMBLG_';
	elsif _pricing_id = 13 then
		_policy_number_prefix := 'NBSLG_';
	elsif _pricing_id = 14 then
		_policy_number_prefix := 'NMBDG_';
	elsif _pricing_id = 15 then
		_policy_number_prefix := 'NKLG_';
	END if;

   return _policy_number_prefix;
end;
$$;


create or replace function get_pricing_plan_updated(_pricing_id int)
returns text
language plpgsql
as
$$
declare
   _pricing_plan text;
begin
	if _pricing_id = 0 then
	  _pricing_plan := 'Synergy';
	elsif _pricing_id = 6 then
	  _pricing_plan := 'Nutun MBD Legal Collections Legacy';
	elsif _pricing_id = 9 then
		_pricing_plan := 'Nutun Kwande Legacy';
	elsif _pricing_id = 7 then 
		_pricing_plan := 'Nutun Business Services SA Legacy';
	elsif _pricing_id = 5 then
		_pricing_plan := 'Nutun Munnik Basson Da Gama Inc Legacy';
	elsif _pricing_id = 3 then
		_pricing_plan := 'Nutun Wellness Legacy';
	elsif _pricing_id = 4 then
		_pricing_plan := 'Nutun Transact Legacy';
    elsif _pricing_id = 1 then
		_pricing_plan := 'Nutun Wellness';
    elsif _pricing_id = 2 then
		_pricing_plan := 'MBD Funeral';
	elsif _pricing_id = 10 then
		_pricing_plan := 'Nutun Transact Group Scheme';
	elsif _pricing_id = 11 then
		_pricing_plan := 'Nutun Wellness Group Scheme';
	elsif _pricing_id = 12 then
		_pricing_plan := 'Nutun Munnik Basson Da Gama Inc Group Scheme';
	elsif _pricing_id = 13 then
		_pricing_plan := 'Nutun Business Services SA Group Scheme';
	elsif _pricing_id = 14 then
		_pricing_plan := 'Nutun MBD Legal Collections Group Scheme';
	elsif _pricing_id = 15 then
		_pricing_plan := 'Nutun Kwande Group Scheme';
	END if;
   	return _pricing_plan;
end;
$$;


create or replace function get_premium_amount_updated(_pricing_plan text)
returns decimal
language plpgsql
as
$$
declare
   _premium decimal;
begin
	if _pricing_plan = 'Nutun Wellness' then
	  _premium := 12.00;
	elsif _pricing_plan = 'MBD Funeral' then
	  _premium := 15.23;
    else
      _premium := 40.00;
	END if;
   
   return _premium;
end;
$$;