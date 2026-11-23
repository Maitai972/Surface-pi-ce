$ErrorActionPreference = 'Stop'
$root = (Resolve-Path $PSScriptRoot).Path
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add('http://localhost:8765/')
$listener.Start()
Write-Host 'Surface Piece est disponible sur http://localhost:8765/' -ForegroundColor Green
Write-Host 'Laissez cette fenetre ouverte pendant l utilisation. Fermez-la pour arreter le serveur.'
$mime = @{
  '.html'='text/html; charset=utf-8'; '.js'='application/javascript; charset=utf-8';
  '.css'='text/css; charset=utf-8'; '.json'='application/json; charset=utf-8';
  '.webmanifest'='application/manifest+json'; '.png'='image/png'; '.svg'='image/svg+xml';
  '.ico'='image/x-icon'; '.txt'='text/plain; charset=utf-8'
}
try {
  while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    try {
      $relative = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath.TrimStart('/'))
      if ([string]::IsNullOrWhiteSpace($relative)) { $relative = 'index.html' }
      $path = [IO.Path]::GetFullPath((Join-Path $root $relative))
      if (-not $path.StartsWith($root, [StringComparison]::OrdinalIgnoreCase) -or -not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $ctx.Response.StatusCode = 404
        $bytes = [Text.Encoding]::UTF8.GetBytes('Not found')
      } else {
        $ext = [IO.Path]::GetExtension($path).ToLowerInvariant()
        $ctx.Response.ContentType = if ($mime.ContainsKey($ext)) { $mime[$ext] } else { 'application/octet-stream' }
        $bytes = [IO.File]::ReadAllBytes($path)
        $ctx.Response.StatusCode = 200
      }
      $ctx.Response.ContentLength64 = $bytes.Length
      $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    } catch {
      try { $ctx.Response.StatusCode = 500 } catch {}
    } finally { $ctx.Response.Close() }
  }
} finally { $listener.Stop(); $listener.Close() }
