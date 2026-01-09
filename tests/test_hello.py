from hello import main
import io
import sys


def test_hello_op(capsys):
    main()
    captured = capsys.readouterr()
    assert captured.out.strip() == "Hello, DevOps!"

