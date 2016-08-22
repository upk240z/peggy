#command helpPHP          "PHP�w���v"
#command helpPEAR         "PEAR�w���v"
#command cleanEmptyLine   "��s�ꊇ�폜"
#command addIFExist       "IF EXISTS�ǉ�"
#command convPHPShortTag  "PHP�V���[�g�^�O�ϊ�"
#command convDOM          "DOM����HTML�ϊ�"
#command cleanSpaceOfTail "�s���X�y�[�X�폜"
#command convSpaceLine    "�X�y�[�X�s�ϊ�"
#command convKBTAppli     "KBT�A�v���J���ϊ�"
#command convPOSTVariable "POST�ϐ���"
#command convGETVariable  "GET�ϐ���"
#command PHPHTMLSpecialChars  "PHP�^�O(htmlspecialchars)"
#command PHPNumberFormat  "PHP�^�O(number_format)"
#command convTab2Space  "�^�u��4�X�y�[�X��"

var PHP_MANUAL_BASE_URL = "http://jp2.php.net/search.php?lang=ja&show=quickref&pattern=";
var PEAR_MANUAL_BASE_URL = "http://pear.php.net/search.php?in=packages&q=";

// �I��͈͂̕�����
var text = getSelectedText().trim();

switch (command) {
	case "helpPHP":
		// �u���E�U���N������B
		shellExecute(
			null,
			PHP_MANUAL_BASE_URL + text
		);
	break;
	case "helpPEAR":
		// �u���E�U���N������B
		shellExecute(
			null,
			PEAR_MANUAL_BASE_URL + text
		);
	break;
	case "cleanEmptyLine":
		enterUndoGroup();
		var no = 1;
		var reg = /^$/;
		var p = new Point();
		while (getLineCount() > no) {
			if (reg.test(getLine(no))) {
				p.line = no;
				gotoPoint(p);
				deleteLine();
			} else {
				no++;
			}
		}
		leaveUndoGroup();
	break;
	case "addIFExist":
		enterUndoGroup();
		replace(/DROP TABLE/ig, "DROP TABLE IF EXISTS");
		replace(/DROP DATABASE/ig, "DROP DATABASE IF EXISTS");
		leaveUndoGroup();
	break;
	case "convPHPShortTag":
		enterUndoGroup();
		replace(/<\?=/ig, "<?php echo");
		replace(/<\? /ig, "<?php ");
		replace(/<\?$/ig, "<?php");
		leaveUndoGroup();
	break;
	case "convDOM":
		enterUndoGroup();
		replace(/src="[^'"]+\/img\//g, "src=\"/img/");
		replace(/href="[^'"]+\/css\//g, "href=\"/css/");
		replace(/heiht\:/g, "height:");
		leaveUndoGroup();
	break;
	case "cleanSpaceOfTail":
		enterUndoGroup();
		replace(/\s+$/g, "");
		leaveUndoGroup();
	break;
	case "convSpaceLine":
		enterUndoGroup();
		replace(/^(\s|\t)+$/g, "");
		leaveUndoGroup();
	break;
	case "convKBTAppli":
		enterUndoGroup();
		replace(/\$_POST\[\"([a-zA-Z0-9_]+)\"\]/g, "$$$1");
		replace(/\$errors\[[^\]]+\]/g, "$$errors[]");
		leaveUndoGroup();
	break;
	case "convPOSTVariable":
		enterUndoGroup();
		var _p1 = getSelection();
		replaceTextBetween(
			_p1[0],
			_p1[1],
			getSelectedText().replace(/\$([a-zA-Z0-9_]+)/g, "@$$_POST[\"$1\"]")
		);
		leaveUndoGroup();
	break;
	case "convGETVariable":
		enterUndoGroup();
		var _p2 = getSelection();
		replaceTextBetween(
			_p2[0],
			_p2[1],
			getSelectedText().replace(/\$([a-zA-Z0-9_]+)/g, "@$$_GET[\"$1\"]")
		);
		leaveUndoGroup();
	break;
	case "PHPHTMLSpecialChars":
		enterUndoGroup();
		var _p3 = getSelection();
		replaceTextBetween(
			_p3[0],
			_p3[1],
			"<?php echo htmlspecialchars(" + getSelectedText() + ") ?>"
		);
		leaveUndoGroup();
	break;
	case "PHPNumberFormat":
		enterUndoGroup();
		var _p4 = getSelection();
		replaceTextBetween(
			_p4[0],
			_p4[1],
			"<?php echo number_format(" + getSelectedText() + ") ?>"
		);
		leaveUndoGroup();
	break;
	case "convTab2Space":
		enterUndoGroup();
		replace(/\t/g, "    ");
		leaveUndoGroup();
	break;
	default:
		error("�s���R�}���h: " + command);
}