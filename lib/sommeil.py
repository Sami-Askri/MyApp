import matplotlib.pyplot as plt
from datetime import datetime
import json

def sec_to_hours(data_dict, start_hour, end_hour):
    hour_minute_data = {}  # Dictionnaire temporaire pour stocker les valeurs par heure et minute
    hour_minute_counts = {}  # Dictionnaire temporaire pour stocker le nombre de valeurs par heure et minute

    # Groupement des valeurs par heure et minute
    for seconds, value in data_dict.items():
        total_seconds = int(seconds)
        hours = total_seconds // 3600
        minutes = (total_seconds % 3600) // 60
        # Ajout des heures de départ
        hours += start_hour
        # Si les heures dépassent 24, ajustez
        if hours >= 24:
            hours -= 24
        # Si les heures sont négatives, ajustez
        elif hours < 0:
            hours += 24

        hour_minute_str = f"{hours:02d}:{minutes:02d}"
        if hour_minute_str not in hour_minute_data:
            hour_minute_data[hour_minute_str] = 0
            hour_minute_counts[hour_minute_str] = 0

        hour_minute_data[hour_minute_str] += value
        hour_minute_counts[hour_minute_str] += 1

    # Calcul de la moyenne pour chaque heure et minute
    result = {}
    for hour_minute_str, value_sum in hour_minute_data.items():
        count = hour_minute_counts[hour_minute_str]
        if count > 0:
            average_value = value_sum / count
            result[hour_minute_str] = average_value

    # Ajout des heures manquantes avec une valeur de 0
    current_hour = start_hour
    while current_hour != end_hour:
        for minute in range(60):
            hour_minute_str = f"{current_hour:02d}:{minute:02d}"
            if hour_minute_str not in result:
                result[hour_minute_str] = 0
        current_hour = (current_hour + 1) % 24

    return result

def tri_heures(data_list=dict):
    # Trier le dictionnaire par les clés (heures)
    dictionnaire_heures_triées = dict(sorted(data_list.items(), key=lambda x: datetime.strptime(x[0], "%H:%M")))

    # Fonction de conversion d'heure en valeur numérique pour le tri
    def heure_en_valeur(heure_str):
        heure, minute = map(int, heure_str.split(':'))
        if heure < 8:
            return heure * 60 + minute + 1440  # Ajoute 1440 minutes (24 heures) pour déplacer les heures avant 08:00
        else:
            return heure * 60 + minute

    # Trier le dictionnaire en utilisant la fonction de conversion d'heure
    dictionnaire_heures_triées2 = dict(sorted(dictionnaire_heures_triées.items(), key=lambda x: heure_en_valeur(x[0])))

    return(dictionnaire_heures_triées2)

def plot_hours_data(data=dict, heures=tuple):
    heure_début = heures[0][:2] + ":" + heures[0][2:]
    heure_fin = heures[1][:2] + ":" + heures[1][2:]
    # Organisez les données en deux listes séparées pour les heures de 22:00 à 00:00 et de 00:00 à 08:00
    hours_22_to_00 = []
    values_22_to_00 = []
    hours_00_to_08 = []
    values_00_to_08 = []

    for hour, value in data.items():
        if hour >= heure_début or hour < heure_fin:
            hours_22_to_00.append(hour)
            values_22_to_00.append(value)
        else:
            hours_00_to_08.append(hour)
            values_00_to_08.append(value)

    # Si nous avons des données pour les heures de 00:00 à 08:00, ajoutez un '24:00' pour gérer la transition
    if hours_00_to_08:
        hours_00_to_08.insert(0, "24:00")
        values_00_to_08.append(values_00_to_08[0])

    # Créez le graphique
    plt.figure(figsize=(12, 6))
    plt.plot(hours_22_to_00 + hours_00_to_08, values_22_to_00 + values_00_to_08, linestyle="-")
    plt.xlabel("Heures")
    plt.ylabel("Intensité de l'accélération")
    plt.title("Graphique des données par heure")
    plt.grid(True)
    plt.xticks([])

    # Définissez les étiquettes de l'axe x pour qu'elles soient plus lisibles
    plt.xticks([ "23:00", "00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00"])
    plt.xticks(rotation=45)

    # Affichez le graphique
    plt.tight_layout()
    plt.show()
    plt.savefig('lib/images/courbe')
hours = (22, 8)
data = {"500": 2.3, "1204": 1.8, "2000": 2.65, "2001": 3.2, "3000": 1.5, "12568":2}
result = sec_to_hours(data, hours[0], hours[1])
print('commented result')
plot_hours_data(tri_heures(result), ("2200", "0800"))
