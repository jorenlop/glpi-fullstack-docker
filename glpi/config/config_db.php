<?php
class DB extends DBmysql {
   public $dbhost = 'glpi-db';
   public $dbuser = 'glpi';
   public $dbpassword = 'glpipass';
   public $dbdefault = 'glpi';
   public $use_utf8mb4 = true;
   public $allow_myisam = false;
   public $allow_datetime = false;
   public $allow_signed_keys = false;
}
