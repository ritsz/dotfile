#include <iostream>
#include <string>

using namespace std;

int main()
{
	string strTapeList= "D2002CD2002DD2002ED2002F";

	string fileTape = strTapeList.substr(0, 6);
	string chunkTape = strTapeList.substr(strTapeList.size() - 6);

	int start = 0;
	int size = 6;
	while(true)
	{
		string tape = strTapeList.substr(start, size);
		cout << tape << endl;
		if ( tape == chunkTape)
			break;

		start = start + size;

		if ( start >= strTapeList.size())
			break;
	}
}
