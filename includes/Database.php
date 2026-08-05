<?php
/**
 * Database Connection Class
 */

class Database {
    private $host;
    private $user;
    private $pass;
    private $db;
    private $connection;
    private $stmt;

    public function __construct() {
        $this->host = DB_HOST;
        $this->user = DB_USER;
        $this->pass = DB_PASS;
        $this->db = DB_NAME;
        $this->connect();
    }

    private function connect() {
        try {
            $this->connection = new mysqli(
                $this->host,
                $this->user,
                $this->pass,
                $this->db,
                DB_PORT
            );

            if ($this->connection->connect_error) {
                throw new Exception('Database Connection Error: ' . $this->connection->connect_error);
            }

            $this->connection->set_charset('utf8mb4');
        } catch (Exception $e) {
            die('Error: ' . $e->getMessage());
        }
    }

    // Prepare statement
    public function prepare($sql) {
        $this->stmt = $this->connection->prepare($sql);
        if (!$this->stmt) {
            throw new Exception('Prepare Error: ' . $this->connection->error);
        }
        return $this;
    }

    // Bind parameters
    public function bind($param, $value, $type = null) {
        if (is_null($type)) {
            switch (true) {
                case is_int($value):
                    $type = MYSQLI_TYPE_LONG;
                    break;
                case is_float($value):
                    $type = MYSQLI_TYPE_DOUBLE;
                    break;
                default:
                    $type = MYSQLI_TYPE_STRING;
            }
        }
        $this->stmt->bind_param($type, $value);
        return $this;
    }

    // Execute statement
    public function execute() {
        if (!$this->stmt->execute()) {
            throw new Exception('Execute Error: ' . $this->stmt->error);
        }
        return true;
    }

    // Get single result
    public function single() {
        $result = $this->stmt->get_result();
        return $result->fetch_assoc();
    }

    // Get all results
    public function resultSet() {
        $result = $this->stmt->get_result();
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    // Get row count
    public function rowCount() {
        return $this->stmt->affected_rows;
    }

    // Close connection
    public function close() {
        if ($this->stmt) {
            $this->stmt->close();
        }
        if ($this->connection) {
            $this->connection->close();
        }
    }
}
