/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market.
    - providing insights into the most valuable skills for job seekers.
*/

SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim     ON skills_job_dim.skill_id  = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5

/* 
- SQL is the clear foundation. At ~92.6k postings, it leads Excel by roughly 38% and Python by about 62%, so it's the one skill that's close to non-negotiable. Employers still expect analysts to pull and shape their own data rather than wait on engineers.

- With ~67k postings, Excel remains the second most requested skill, ahead of Python. Spreadsheet fluency is still the everyday language of business stakeholders, so it's a strong signal that many roles are business-facing rather than purely technical.

- Tableau (~46.6k) and Power BI (~39.5k) together total about 86k mentions, nearly matching SQL, which shows that communicating insights matters as much as querying data. Power BI trails Tableau slightly, but the two are largely interchangeable, so learning one well and being familiar with the other is a sensible approach.

[
  {
    "skills": "sql",
    "demand_count": "92628"
  },
  {
    "skills": "excel",
    "demand_count": "67031"
  },
  {
    "skills": "python",
    "demand_count": "57326"
  },
  {
    "skills": "tableau",
    "demand_count": "46554"
  },
  {
    "skills": "power bi",
    "demand_count": "39468"
  }
]
 */