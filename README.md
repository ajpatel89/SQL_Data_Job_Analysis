# Introduction
A dive into the Data Analyst job market. Focusing on top paying jobs, high demand skills, and where high demand meets high salary. 

SQL Queries: [project_sql folder](/project_sql/)

# Background
Project to pinpoint top-paid and in-demand skills, streamlining a method to find the optimal job.

Data Source: [SQL Course](https://drive.google.com/drive/folders/1egWenKd_r3LRpdCf4SsqTeFZ1ZdY3DNx?usp=share_link)
Includes job titles, salaries, locations, and essential skills. 

### Questions to Answer
1. What are the top-paying jobs for my role?
2. What are the skills required for these top-paying roles?
3. What are the most in-demand skills for my role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills (High Demand and High Paying) to learn?

# Tools I Used
- **SQL**: Fundamental to my analysis, allowing me to query the database and unearth crtical insights.
- **PostgreSQL**: The chosen database management system., ideal for handling the job posting data. 
- **Visual Studio Code**: For database management and executing SQL queries. 
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, enabling collaboration and project tracking. 

# The Analysis
Each query for this project aimed at investigating specific aspects of the Data Analyst job market. 
Here's how I approached each question:

#### 1. What are the top-paying jobs for my role?
To identify the highest paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunites in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND
    job_location    = 'Anywhere'
    AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
- **Pay Range:** $184K to $650K, but the $650K Mantys listing is likely an outlier. Without it, the average is about $227K.
- **Seniority pays most:** Director roles (Meta at $336.5K) top the list, while Principal-level roles reliably land at $186K to $205K.
- **Not just Big Tech:** Healthcare, Telecom and FinTech all pay $185K to $255K.
- **Domain expertise helps:** Marketing, Risk and AV Analytics roles earn premiums.

![Top Paying Roles](assets/1_top_paying_jobs.png)

#### 2. What are the skills required for these top-paying roles?

To understand what skills are required for the top-paying jobs, I joined the jobs postings with the skills data, providing insights into what emplloyers value for high compensation roles. 

```sql
WITH top_paying_jobs AS(
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN
        company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND
        job_location    = 'Anywhere'
        AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
    )

SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN 
    skills_job_dim ON top_paying_jobs.job_id  = skills_job_dim.job_id
INNER JOIN 
    skills_dim     ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

**SQL, Python and Tableau are the core stack.** SQL appears in all 8 postings, Python in 7 and Tableau in 6. If you only learn three tools, learn these. Tableau is also far more common than Power BI, which appears in only 2.

**Cloud and data warehouse skills are the next step up.** Snowflake appears in 3 postings, and Azure, AWS and Oracle in 2 each. Only the AT&T role, the highest paid at $256K, asks for a full big-data stack (Databricks, PySpark and two clouds). For most of the others, one warehouse plus basic cloud familiarity is enough.

**Seniority drives pay more than the number of skills.** Associate Director, Director and Principal titles fill the list. The top role lists 13 skills and the lowest-paid lists 3, but UCLA Health pays $217K for just 5. A longer skill list doesn't guarantee a higher salary.

**Engineering-style tools show up at senior levels.** Jira, Confluence, Bitbucket, Git and GitLab appear in about a quarter of the postings. Senior analyst roles seem to expect version control and team workflow knowledge alongside analysis, and Excel still appears even at principal level.

![Skills Count for Top Paying Jobs](assets/2_top_paying_jobs_skills.png)



# What I Learned
# Conclusions
