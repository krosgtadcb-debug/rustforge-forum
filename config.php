<?php
declare(strict_types=1);

session_set_cookie_params([
    'httponly' => true,
    'samesite' => 'Lax',
    'secure' => (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off'),
]);
session_start();

$host = getenv('DB_HOST') ?: '127.0.0.1';
$name = getenv('DB_NAME') ?: 'rustforge';
$user = getenv('DB_USER') ?: 'root';
$pass = getenv('DB_PASS') ?: '';
$dsn = "mysql:host={$host};dbname={$name};charset=utf8mb4";
try {
    $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
} catch (PDOException $e) {
    http_response_code(503);
    exit('Base de datos no disponible. Revisa DB_HOST, DB_NAME, DB_USER y DB_PASS.');
}

function e(?string $value): string { return htmlspecialchars($value ?? '', ENT_QUOTES, 'UTF-8'); }
function url(string $page = 'home', array $params = []): string { return '?' . http_build_query(array_merge(['page' => $page], $params)); }
function current_user(): ?array { return $_SESSION['user'] ?? null; }
function is_staff(): bool { return in_array(current_user()['role'] ?? '', ['admin', 'moderator'], true); }
function is_admin(): bool { return (current_user()['role'] ?? '') === 'admin'; }
function flash(?string $message = null, string $type = 'ok'): ?array { if ($message) $_SESSION['flash'] = [$message, $type]; $f = $_SESSION['flash'] ?? null; unset($_SESSION['flash']); return $f; }
function csrf(): string { if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(24)); return $_SESSION['csrf']; }
function check_csrf(): void { if (!hash_equals($_SESSION['csrf'] ?? '', $_POST['csrf'] ?? '')) { http_response_code(419); exit('Token CSRF inválido.'); } }
function redirect(string $target): never { header('Location: ' . $target); exit; }
function setting(PDO $pdo, string $key, string $fallback = ''): string { $s = $pdo->prepare('SELECT setting_value FROM settings WHERE setting_key=?'); $s->execute([$key]); return (string)($s->fetchColumn() ?: $fallback); }
