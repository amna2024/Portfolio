# Del 1: Projekt Story
**Scenario:**  
Mstile needs assistance in structuring their data for customer and contract visits and is considering whether a SharePoint list is the right tool.

**Task:**  
Create a SharePoint list with the following columns:

### Kund (Customer)
- **Kundnamn (Customer Name)**
- **Avtal (Contract)**
- **Pris (Price)**
- **Epost (Email)**
- **Avtal på skriven (Contract Signed)**
- **Ansvarig (Responsible Person)**

### Avtalsbesök (Contract Visits)
- **Kund (Customer)**
- **Ansvarig (Responsible Person)**
- **Startdatum (Start Date)**
- **Avtal (Contract)**
- **Avtalsstatus (Contract Status)**
- **Kontaktperson (Contact Person)**
- **Antal timmar per besök (Hours per Visit)**
- **Avtalsvärde (Contract Value)**

# Del 2: Projekt Story
**Scenario:**  
Mstile is satisfied with the list that was created but finds it challenging to work with and asks for help in improving the user experience.

**Task:**  
Format the list with the following requirements:

### Kund (Customer)
- **Kundnamn (Customer Name)**
- **Avtal (Contract)**
- **Pris (Price):** Automatically filled based on the contract.
- **Epost (Email):** Highlight with color or icon if missing.
- **Avtal på skriven (Contract Signed):** Highlight with color or icon if missing.
- **Ansvarig (Responsible Person):** Highlight with color or icon if missing.

### Avtalsbesök (Contract Visits)
- **Kund (Customer):** Lookup column type.
- **Ansvarig (Responsible Person):** Highlight with color or icon if missing.
- **Startdatum (Start Date):** Highlight with color or icon if missing.
- **Avtal (Contract)**
- **Avtalsstatus (Contract Status)**
- **Kontaktperson (Contact Person):** Highlight with color or icon if missing.
- **Antal timmar per besök (Hours per Visit):** Highlight with color or icon if missing.
- **Avtalsvärde (Contract Value):** Automatically calculated based on “Hours per Visit” and “Contract Type”.

# Del 3: Projekt Story
**Scenario:**  
Mstile is very pleased with the formatting but wonders if their work process can be further optimized.

**Task:**  
Use Power Automate to achieve the following:

- **Create a new contract visit** when a new customer is added to the customer list.
- **Create a new contract visit** when the “Contract Signed” status is changed to "Yes."
- **Send an email** to the responsible person when:
  - A new item is created.
  - An existing item is updated.
  - A new contract is created.
