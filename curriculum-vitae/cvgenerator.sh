# cvgenerator.sh
# Script to generate the curriculum vitae in HTML, PDF, ODT and plain text

FROM=$1
TO=$2

if [[ "$1" != "" ]]; then
  FROM="$1"
else
  FROM="cv.md"
fi

if [[ "$2" != "" ]]; then
  TO="$2"
else
  TO="cv"
fi

echo "Welcome to the Curriculum Vitae generator!"

echo "Generating HTML..."
pandoc --standalone -c style.css --from markdown --to html5 -o $TO.html $FROM

echo "Generating PDF..."
# This changes the background color of the body in style.css from grey to white
# before to convert the HTML in to PDF.
sed -i "s#f2f2f2#fff#g" style.css
wkhtmltopdf $TO.html $TO.pdf
# After conversion to PDF, change again the style.css
sed -i "s#fff#f2f2f2#g" style.css

echo "Generating plain text..."
pandoc --standalone --from markdown --to plain -o $TO.txt $FROM

echo "Task finished!"
