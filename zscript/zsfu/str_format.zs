/*
    What: ZScript String Format Utility Class Definition
    Who: Sarah Blackburn
    When: 09-03-2024

*/

class str_format
{
    private string Format;

    private array<int>      arInts;
    private array<double>   arDbls;
    private array<string>   arStrs;

    private int ic, dc, sc;

    str_format Init(string Format, array<int> arInts = null, array<double> arDbls = null, array<string> arStrs = null)
    {
        self.Format = Format;
        ic = dc = sc = 0;
        if (arInts)
            self.arInts.Copy(arInts);
        if (arDbls)
            self.arDbls.Copy(arDbls);
        if (arStrs)
            self.arStrs.Copy(arStrs);
        return self;
    }

    void PushInt (int i) { arInts.Push(i); }
    void PushDbl (double d) { arDbls.Push(d); }
    void PushStr (string s) { arStrs.Push(s); }

    string FormatOut()
    {
        array<string> fa;
        string fr;
        Format.Split(fa, "%");
        if (fa.Size() > 0)
        {
            for (int i = 0; i < fa.Size(); i++)
            {
                if (fa[i] ~== "d") // d here means integer
                    fr.AppendFormat("%d", arInts[ic++]);
                else if (fa[i] ~== "f") // f here means fixed or float
                    fr.AppendFormat("%f", arDbls[dc++]);
                else if (fa[i] ~== "s") // s actually means string - or I guess also char
                    fr.AppendFormat("%s", arStrs[sc++]);
                else
                    console.printf(string.Format("\cyZSFU \cu- \ciUnsupported argument type - got: \cd%", fa[i]));
            }
        }
        else
            console.printf("\cyZSFU \cu- \ciFormatted string was empty!");
        
        return fr;
    }
}