import importlib.util
import pathlib


def load_hello_module():
    project_root = pathlib.Path(__file__).parent.parent
    hello_path = project_root / "hello.py"

    spec = importlib.util.spec_from_file_location("hello", hello_path)
    hello = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(hello)

    return hello


def test_hello_output(capsys):
    hello = load_hello_module()
    result = hello.main()

    captured = capsys.readouterr()
    assert "Hello, DevOps!" in captured.out
    assert result is not None
