-- Note: Generally it is better to handle this sort of thing on the client side rather than
-- Letting a prohibited request make its way to the DB

-- Validation trigger: prevents users from following themselves
DELIMITER $$

CREATE TRIGGER prevent_self_follows 
    BEFORE INSERT ON follows FOR EACH ROW
    BEGIN
        IF NEW.follower_id  = NEW.followee_id
        THEN 
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "You cannot follow yourself";
        END IF;
        
    END 
$$

-- Logging trigger: log when one user unfollows another

CREATE TRIGGER capture_unfollow
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        INSERT INTO unfollows
        SET follower_id = OLD.follower_id,
            followee_id = OLD.followee_id;
    END;
$$

