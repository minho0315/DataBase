SELECT `employees`.`emp_no`,
    `employees`.`birth_date`,
    `employees`.`first_name`,
    `employees`.`last_name`,
    `employees`.`gender`,
    `employees`.`hire_date`
FROM `employees`.`employees`;

UPDATE `employees`.`employees`
SET
`emp_no` = <{emp_no: }>,
`birth_date` = <{birth_date: }>,
`first_name` = <{first_name: }>,
`last_name` = <{last_name: }>,
`gender` = <{gender: }>,
`hire_date` = <{hire_date: }>
WHERE `emp_no` = <{expr}>;

