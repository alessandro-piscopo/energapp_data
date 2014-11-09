import csv
import string

month_KWh=[0 for i in range(12)];
year_KWh = 0;
fraction=[0 for i in range(12)];
month = 0;
with open('dagprofiele.csv', 'rb') as csvfile:
	data = csv.reader(csvfile,delimiter=';');
	next(data, None);		
	for row in data:
		date = str(row[0]);
		hour = str(row[1]);
		if (date.split("-")[1]=="01") & (hour.split(":")[0]=="00"):		
			month+=1
		hour_KWh = string.atof(row[5].replace(",","."));
		month_KWh[month] += hour_KWh;
		year_KWh += hour_KWh;

for i in range(12):
	fraction[i] = month_KWh[i]/year_KWh;
