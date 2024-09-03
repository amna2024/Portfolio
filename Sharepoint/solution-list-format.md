# Project: Structuring Data for Mstile

## Del 1: Creating a SharePoint List

### Project Story
Mstile needs help structuring their data for customer and contract visits and is considering using a SharePoint list as a solution.

### Task
Create a SharePoint list with the following columns:

**Kund (Customer):**
- Kundnamn (Customer Name)
- Avtal (Contract)
- Pris (Price)
- Epost (Email)
- Avtal på skriven (Contract Signed)
- Ansvarig (Responsible Person)

**Avtalsbesök (Contract Visit):**
- Kund (Customer)
- Ansvarig (Responsible Person)
- Startdatum (Start Date)
- Avtal (Contract)
- Avtalsstatus (Contract Status)
- Kontaktperson (Contact Person)
- Antal timmar per besök (Hours per Visit)
- Avtalsvärde (Contract Value)

## Del 2: Formatting the List

### Project Story
Mstile is satisfied with the list but finds it challenging to work with and wants a better user experience.

### Task
Format the SharePoint list as follows:

**Kund (Customer):**
- Kundnamn (Customer Name)
- Avtal (Contract)
- Pris (Price) - Automatically filled based on the contract.
- Epost (Email) - Format with color or icon if missing.
- Avtal på skriven (Contract Signed) - Format with color or icon if missing.
- Ansvarig (Responsible Person) - Format with color or icon if missing.

**Avtalsbesök (Contract Visit):**
- Kund (Customer) - Lookup column type.
- Ansvarig (Responsible Person) - Format with color or icon if missing.
- Startdatum (Start Date) - Format with color or icon if missing.
- Avtal (Contract)
- Avtalsstatus (Contract Status)
- Kontaktperson (Contact Person) - Format with color or icon if missing.
- Antal timmar per besök (Hours per Visit) - Format with color or icon if missing.
- Avtalsvärde (Contract Value) - Automatically calculated based on “antal timmar per besök” (hours per visit) and type of “avtal” (contract).

## Del 3: Automating Processes with Power Automate

### Project Story
Mstile is very satisfied with the formatting but wants to further streamline their workflow.

### Task
- Use Power Automate to create a new "Avtalsbesök" (Contract Visit) when a new customer is added to the "Kund" (Customer) list.
- Use Power Automate to create a new "Avtalsbesök" (Contract Visit) when the "Avtal på skriven" (Contract Signed) status changes to "Yes."
- Implement the following:
  - Send an email to the responsible person when a new item is created.
  - Send an email to the responsible person when an item is modified.
  - Send an email to the responsible person when a new contract is created.

