new_emails = ['dan@ndadc.co.za','athenkosi@assuredlife.co.za','seb@ndadc.co.za','morne@ndadc.co.za','antonio@ndadc.co.za','tatum@assuredlife.co.za','saadiqah@assuredlife.co.za','ayanda@assuredlife.co.za','masimbonge-masi@assuredlife.co.za','zandile.m@assuredlife.co.za','melezwa@assuredlife.co.za']
old_emails = ["dan@ndadc.co.za","melezwa@assuredlife.co.za","masimbonge-masi@assuredlife.co.za","tatum@assuredlife.co.za","ayanda@assuredlife.co.za","zandile.m@assuredlife.co.za","morne@ndadc.co.za","antonio@ndadc.co.za","seb@ndadc.co.za"]


emails = [x for x in new_emails if x not in old_emails]

print(emails)