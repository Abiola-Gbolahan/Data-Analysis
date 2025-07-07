# SQL Data Cleaning Project
I came across this data cleaning project online and decided to give it a try to sharpen my SQL skills. Though I initially faced some technical hurdles, I was determined to make it work and I learned a lot in the process.
The goal was to clean and prepare a dataset of global layoffs to make it analysis-ready. This project made me realize how **important it is to clean data before diving into Exploratory Data Analysis (EDA)**. Working with messy or inconsistent data can lead to wrong insights and poor business decisions.

## ⚙️ Tools & Environment
* **Database**: PostgreSQL (PGAdmin)
* **Data Source**: CSV format (converted for compatibility)
* **Assistance**: ChatGPT (for converting JSON to SQL insert statements)

---

## 📁 Dataset Import Challenges

Initially, I struggled to import the raw CSV file directly into PostgreSQL. The import kept failing, so I converted the CSV to JSON, then generated SQL insert statements using ChatGPT. This workaround allowed me to populate the database successfully.

---

## 🧽 Cleaning Tasks Performed

I documented and commented every part of the query to make it beginner-friendly and easy to follow. Below are the key steps I took in cleaning the data:

### 1. **Creating a Backup Table**

Before making any changes, I copied the original table into a new one (`layoffs`) to ensure the raw data was preserved.

### 2. **Removing Duplicates**

Used `ROW_NUMBER()` with a `PARTITION BY` clause to identify duplicate rows based on all major columns. Since direct deletion via CTEs isn’t allowed in PostgreSQL, I used a workaround by creating and cleaning a new table.

### 3. **Standardizing Text Values**

* Trimmed extra spaces in the `company` column.
* Standardized values in Industry column like "CryptoCurrency", "Crypto Currency", etc., to just "Crypto".
* Corrected typos like "United States. " → "United States".

### 4. **Handling Null and Blank Values**

* Converted empty strings (`''`) to `NULL`.
* Used self-joins to populate missing `industry` values based on matching `company` names.

### 5. **Dropping Unnecessary Rows and Columns**

* Removed rows where both `total_laid_off` and `percentage_laid_off` were `NULL`, as they offered no analytical value.
* Dropped helper columns like `row_number` once they were no longer needed.

---

## 🧠 Key Learnings

* **PostgreSQL syntax** is slightly different from MySQL. I had to adjust my approach several times due to syntax limitations, especially with `JOIN` updates and CTE deletions.
* **Data cleaning** is not just a step—it’s a mindset. It requires both attention to detail and a deep understanding of the dataset.
* I now appreciate the **importance of clean data**. Without it, any form of analysis can be misleading, no matter how advanced it is.

---

## 🔗 Resources

* 📄 [Raw Dataset](#)
* 🧼 [Cleaned Dataset](#)
* 🧾 [Final SQL Cleaning Query](#)


---

## my Final Thoughts

This project is a great demonstration of my **SQL data wrangling skills**, **problem-solving mindset**, and **adaptability**. I faced real-world challenges and tackled them creatively, using both tools and community resources to reach my goal.

If you’re a hiring manager or team lead, I’d love to bring this same energy and mindset to your team.

Let’s build something clean and powerful together.


