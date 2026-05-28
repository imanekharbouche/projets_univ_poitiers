#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from tkinter import *
from tkinter import messagebox
from PIL import Image, ImageTk
import subprocess
import mysql.connector
import csv
from tkinter.filedialog import asksaveasfilename

# ========== CONFIG BDD ==========
"""
params = {
    'user': 'root',
    'password': 'root',
    'host': 'localhost',
    'unix_socket': '/Applications/MAMP/tmp/mysql/mysql.sock',
    'database': 'selmarin',
    'raise_on_warnings': True
}

"""
# Paramètres pour EasyPHP (utilisé ici)
params = {"host":"localhost","user":"root","password":"","database":"selmarin"} 


# ========== FONCTIONS ==========

def show_table_data(title, colnames, data):
    data_window = Toplevel(root)
    data_window.title(title)
    data_window.geometry("1000x500")

    canvas = Canvas(data_window, bg="white")
    frame = Frame(canvas, bg="white")
    scrollbar = Scrollbar(data_window, orient="vertical", command=canvas.yview)
    canvas.configure(yscrollcommand=scrollbar.set)

    scrollbar.pack(side=RIGHT, fill=Y)
    canvas.pack(side=LEFT, fill=BOTH, expand=True)
    canvas.create_window((0, 0), window=frame, anchor='nw')

    def on_configure(event):
        canvas.configure(scrollregion=canvas.bbox("all"))

    frame.bind("<Configure>", on_configure)

    col_width = 20

    for c, name in enumerate(colnames):
        Label(frame, text=name, bg="lightgray", fg="black", width=col_width,
              anchor='w', padx=5, pady=5, relief="ridge").grid(row=0, column=c, sticky="nsew")

    for r, row in enumerate(data, start=1):
        for c, value in enumerate(row):
            Label(frame, text=str(value), bg="white", width=col_width,
                  anchor='w', padx=5, pady=5, relief="ridge").grid(row=r, column=c, sticky="nsew")

    def export_csv():
        file_path = asksaveasfilename(defaultextension=".csv", filetypes=[("CSV Files", "*.csv")])
        if file_path:
            try:
                with open(file_path, mode='w', newline='', encoding='utf-8') as f:
                    writer = csv.writer(f, delimiter=';')
                    writer.writerow(colnames)
                    writer.writerows(data)
                messagebox.showinfo("Succès", "Données exportées avec succès !")
            except Exception as e:
                messagebox.showerror("Erreur", str(e))

    Button(data_window, text="Exporter en CSV", command=export_csv,
           fg="black", padx=10, pady=5).pack(pady=10)

def run_sql_file(filepath):
    try:
        conn = mysql.connector.connect(**params)
        cursor = conn.cursor()
        with open(filepath, 'r', encoding='utf-8') as file:
            sql_commands = file.read()
            for command in sql_commands.split(';'):
                command = command.strip()
                if command:
                    cursor.execute(command)
        conn.commit()
        conn.close()
        messagebox.showinfo("Succès", str("Le fichier " + filepath + " a été exécuté avec succès."))
    except mysql.connector.Error as err:
        messagebox.showerror("Erreur SQL", str("Erreur dans " + filepath + " :\n" + str(err)))
    except Exception as e:
        messagebox.showerror("Erreur", str(e))

def create_database():
    run_sql_file("selmarin_create.sql")

def insert_from_sql():
    run_sql_file("selmarin_insert.sql")

def openfile():
    try:
        new_window = Toplevel(root)
        new_window.title("MCD de la base de données")
        img = Image.open("selmarinmcd.png")
        img = img.resize((1000, 600))
        img_tk = ImageTk.PhotoImage(img)
        label = Label(new_window, image=img_tk, bg="white")
        label.image = img_tk
        label.pack(pady=10)
    except Exception as e:
        messagebox.showerror("Erreur", str(e))

def insertion_tuples():
    if messagebox.askyesno("Confirmation", "Voulez-vous vraiment insérer les tuples depuis Excel ?"):
        try:
            result = subprocess.run(['python', 'selmarin.py'], check=True, capture_output=True, text=True)
            messagebox.showinfo("Succès", "Insertion réussie.")
        except subprocess.CalledProcessError as e:
            messagebox.showerror("Erreur", str("Échec de l'insertion :\n" + str(e.stderr)))

def fetch_table_data(table_name):
    try:
        conn = mysql.connector.connect(**params)
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM " + table_name)
        data = cursor.fetchall()
        colnames = [i[0] for i in cursor.description]
        conn.close()
        show_table_data(str("Table : " + table_name), colnames, data)
    except mysql.connector.Error as err:
        messagebox.showerror("Erreur SQL", str(err))

def load_queries():
    try:
        with open('selmarin_requetes.sql', 'r', encoding='utf-8') as file:
            content = file.read()
            raw_queries = content.split('--')[1:]
            descriptions = []
            queries = []
            for raw in raw_queries:
                parts = raw.strip().split('\n', 1)
                if len(parts) == 2:
                    descriptions.append(parts[0].strip())
                    queries.append(parts[1].strip().rstrip(';'))
            return descriptions, queries
    except Exception as e:
        messagebox.showerror("Erreur", str(e))
        return [], []

def execute_query(query):
    try:
        conn = mysql.connector.connect(**params)
        cursor = conn.cursor()
        cursor.execute(query)

        if query.strip().lower().startswith("select"):
            data = cursor.fetchall()
            colnames = [i[0] for i in cursor.description]
            if data:
                show_table_data("Résultat de la requête", colnames, data)
            else:
                messagebox.showinfo("Aucun résultat", "Aucun résultat trouvé pour cette requête.")
        else:
            conn.commit()
            messagebox.showinfo("Succès", "Requête exécutée avec succès.")

        while cursor.nextset():
            pass

        conn.close()
    except mysql.connector.Error as err:
        messagebox.showerror("Erreur SQL", str(err))

def open_query_window():
    query_window = Toplevel(root)
    query_window.title("Exécuter une requête SQL")

    Label(query_window, text="Entrez votre requête SQL :").pack()

    query_entry = Text(query_window, width=60, height=5)
    query_entry.pack(pady=5)

    def run_query():
        query = query_entry.get("1.0", END).strip()
        if query:
            execute_query(query)

    Button(query_window, text="Éxecuter", command=run_query).pack(pady=5)
    Button(query_window, text="Voir le MCD", command=openfile).pack(pady=5)

def execute_selected_query():
    try:
        selected_query_description = req_var.get()
        selected_query_index = query_descriptions.index(selected_query_description)
        query = queries[selected_query_index]

        conn = mysql.connector.connect(**params)
        cursor = conn.cursor()

        cursor.execute(query)

        if query.strip().lower().startswith("select"):
            data = cursor.fetchall()
            colnames = [i[0] for i in cursor.description]
            if data:
                show_table_data(str("Résultat de la requête : " + selected_query_description), colnames, data)
            else:
                messagebox.showinfo("Aucun résultat", "Aucun résultat trouvé pour cette requête.")
        else:
            conn.commit()
            messagebox.showinfo("Succès", "Requête exécutée avec succès.")

        while cursor.nextset():
            pass

        cursor.close()
        conn.close()

    except mysql.connector.Error as err:
        messagebox.showerror("Erreur SQL", str(err))
    except Exception as e:
        messagebox.showerror("Erreur", str(e))

def close_window():
    root.quit()
    root.destroy()

# ========== FENÊTRE PRINCIPALE ==========

root = Tk()
root.title("Les sauniers de l'île de Ré")
root.config(bg="white")

Label(root, text="Les sauniers de l'île de Ré", font=("Helvetica", 16, "bold"),
      bg="#C3B1E1", fg="white", padx=10, pady=10).grid(row=0, column=0, columnspan=4, pady=10)

Label(root, text="Récolte, conditionnement et distribution de sel par les sauniers de l'île de Ré.",
      bg="white", fg="black").grid(row=1, column=0, columnspan=4)
Label(root, text="Interface pour gérer les sauniers, les produits et les clients.",
      bg="white", fg="black").grid(row=2, column=0, columnspan=4)

Button(root, text="Créer la base", command=create_database,
       bg="white", fg="black").grid(row=3, column=0, pady=10)
Button(root, text="Insérer depuis SQL", command=insert_from_sql,
       bg="white", fg="black").grid(row=3, column=1, pady=10)
Button(root, text="Insertion des tuples", command=insertion_tuples,
       bg="white", fg="black").grid(row=3, column=2, pady=10)
Button(root, text="Voir le MCD", command=openfile,
       bg="white", fg="black").grid(row=3, column=3, pady=10)

Label(root, text="Afficher une table :", bg="white", fg="black").grid(row=4, column=0)
tables = ["Saunier", "Client", "Entree", "Sortie"]
table_var = StringVar(root)
table_var.set(tables[0])
OptionMenu(root, table_var, *tables).grid(row=4, column=1)
Button(root, text="Afficher", command=lambda: fetch_table_data(table_var.get()),
       fg="black").grid(row=4, column=2)

query_descriptions, queries = load_queries()

Label(root, text="Requête pré-définie :", bg="white", fg="black").grid(row=5, column=0)
req_var = StringVar(root)
req_var.set(query_descriptions[0])
OptionMenu(root, req_var, *query_descriptions).grid(row=5, column=1)
Button(root, text="Exécuter", command=execute_selected_query,
       fg="black").grid(row=5, column=2)

Button(root, text="Requête personnalisée", command=open_query_window,
       fg="black").grid(row=6, column=0, pady=20)
Button(root, text="Quitter", command=close_window,
       fg="black").grid(row=6, column=3, pady=20)

root.mainloop()
