<?php
declare(strict_types=1);

// BluefinDecryptx SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class BluefinDecryptxFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new BluefinDecryptxBaseFeature();
            case "test":
                return new BluefinDecryptxTestFeature();
            default:
                return new BluefinDecryptxBaseFeature();
        }
    }
}
