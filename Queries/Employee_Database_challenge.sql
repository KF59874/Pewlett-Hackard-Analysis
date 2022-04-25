SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
	ON (e.emp_no=t.emp_no)	
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (r.emp_no) r.emp_no, 
	r.first_name, 
	r.last_name,
	r.title
INTO unique_titles
FROM retirement_titles as r
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Retrieve number of titles from the Unique Titles table
SELECT COUNT(u.title), u.title
INTO retiring_titles
FROM unique_titles as u
GROUP BY u.title
ORDER BY count(u.title) DESC;

-- Mentorship Eligibility program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e 
INNER JOIN dept_emp as de
	ON (e.emp_no=de.emp_no)
INNER JOIN titles as t
	ON (e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

