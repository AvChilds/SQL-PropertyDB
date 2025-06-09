# 🏡 SQL Property Database – Essex Lettings Project

> A relational database project simulating a **short-term lettings company in Essex**, created as part of my Code First Girls Data Science & SQL learning journey.

![SQL Icon](https://img.shields.io/badge/SQL-Mysql-blue?logo=mysql&style=flat-square)
![Project Type](https://img.shields.io/badge/Project-Database%20Design-lightgrey)
![Tech Torty Badge](https://img.shields.io/badge/Made%20by-TechTorty-96c5c0)

---

## 📘 Project Story

A short-let property agency operating in Essex wants to manage:
- The **towns** they operate in
- The **properties** they list
- The **bookings** made in February

I built this SQL project to model the business, explore relational data, and provide insights that agents could use to promote and manage listings.

--- 

### 💬 Notes
This project demonstrates data modelling, real-world logic, and business analysis with SQL. It showcases how structured data can drive insight and decision-making in a rental/lettings context.

---

## 🗃️ Tables & Schema

| Table Name     | Description                                       |
|----------------|---------------------------------------------------|
| `towns`        | 🏙️ Towns the company covers (Basildon, Thurrock, etc.) |
| `properties`   | 🏡 Listings with rooms, street names & town links |
| `bookingsFeb`  | 📅 Bookings made in February with dates & revenue |

---

## 🔍 Sample Queries & Features

- 🛏️ **Stay Duration Calculation** using `DATEDIFF`
- 🏷️ **Most & Least Expensive** listings by room/day
- 📈 **Revenue Reports** by town using a **stored function**
- 🧾 **Average price paid** per property by town
- ⛔ **Identify unbooked properties** to promote
- 👀 **Custom View** of properties with bookings
- ⚙️ A **stored procedure** to calculate town revenue anytime

---

## ⚒️ SQL Features Used

- `CREATE VIEW` for readable property-booking data  
- `ALTER TABLE` & `UPDATE` for dynamic insights  
- `LEFT JOIN`, `RIGHT JOIN`, `GROUP BY`, `HAVING`, `CHECK` constraints  
- `STORED PROCEDURE` + `FUNCTION` for automation  
- Data validation (e.g., positive room numbers & prices)

---

## 💻 Tech Stack

- 💾 MySQL
- 🧠 SQL logic and joins
- 🐢 Built by [TechTorty](https://github.com/AvChilds)  
  [![Codewars badge](https://www.codewars.com/users/techTorty/badges/small)](https://www.codewars.com/users/techTorty)

---

## 📊 Sample Output

> 📌 “What are the top 3 most expensive properties per room per day?”

| propertyID | listingNo | townName   | daily_price_per_room |
|------------|-----------|------------|------------------------|
| 5          | 23546     | Brentwood  | £67.50                |
| 18         | 75894     | Colchester | £60.00                |
| 8          | 32645     | Chelmsford | £43.33                |

>⚠️ Note: These values are not stored in the database; they are calculated dynamically at query time.
---

## 🧭 Future Enhancements

- Add triggers to validate booking overlaps
- Expand to cover full-year booking data


---

🪄 Built with magic & queries by **Tech Torty**  
🚀 *Learning to wrangle data one JOIN at a time!*
