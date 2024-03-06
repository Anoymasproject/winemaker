INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_winemaker','Winemaker',1)
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_winemaker','Winemaker', 1)
;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_winemaker', 'Winemaker', 1)
;

INSERT INTO `jobs`(`name`, `label`, `whitelisted`) VALUES
	('winemaker', 'Winemaker', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary) VALUES
	('winemaker',0,'novice','Novice', 50),
	('winemaker',1,'winemaker','Expert', 60),
	('winemaker',2,'manager','Manager', 70),
	('winemaker',3,'boss','Boss', 80)
;