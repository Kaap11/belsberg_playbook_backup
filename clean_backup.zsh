#!/bin/zsh
set -e

SRC_DIR="$(pwd)"
BACKUP_DIR="../Belsberg_Salesplaybook_BACKUP_CLEAN"

echo "Bronmap:  $SRC_DIR"
echo "Backup:   $BACKUP_DIR"
echo ""

rm -rf "$BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
rsync -a "$SRC_DIR/" "$BACKUP_DIR/"

rm -rf "$BACKUP_DIR/site"
rm -rf "$BACKUP_DIR/.git"
rm -rf "$BACKUP_DIR/__MACOSX"

find "$BACKUP_DIR" -name ".DS_Store" -delete
find "$BACKUP_DIR" -name "._*" -delete

rm -f "$BACKUP_DIR/CNAME"
rm -f "$BACKUP_DIR/docs/CNAME"

cat > "$BACKUP_DIR/.gitignore" <<'EOG'
site/
.DS_Store
__MACOSX/
._*
EOG

cat > "$BACKUP_DIR/requirements.txt" <<'EOR'
mkdocs==1.6.1
mkdocs-material==9.5.30
EOR

if [ ! -f "$BACKUP_DIR/.github/workflows/deploy.yml" ]; then
  echo "⚠️  LET OP: .github/workflows/deploy.yml ontbreekt!"
else
  echo "✅ Workflow gevonden: .github/workflows/deploy.yml"
fi

echo ""
echo "🎉 Clean backup klaar in:"
echo "$BACKUP_DIR"
