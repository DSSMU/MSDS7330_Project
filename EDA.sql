# Some of the dates provided don't make sense, make them NULL
UPDATE securities set Date_first_added = NULL WHERE Date_first_added = "0000-00-00";
