using System;
using System.IO;

namespace agma
{
    class Program
    {
        //reference: https://sdp-si.com/plastic/design-of-plastic-gears.php
        //contract: mcmaster's nylon has negligible differences in mechanical properties to this manufacturer's

        //ref: table 18-1 of link
        public static float[] formFactorTable =
            {
                0f, //0 teeth, cant hold load
                0.15f,0.15f,0.15f,0.15f,0.15f,0.15f,0.15f,0.15f,0.15f,0.15f,0.15f, //1-11 teeth, conservative form factor
				0.355f,0.355f, //12-13
				0.399f,0.399f, //14-15
				0.430f,0.430f, //16-17
				0.458f,0.458f, //18-19
				0.480f,0.480f, //20-21
				0.496f,0.496f, //22-23
				0.509f,0.509f, //24-25
				0.522f,0.522f, //26-27
				0.535f,0.535f, //28-29
				0.540f,0.540f,0.540f,0.540f, //30-33
				0.553f,0.553f,0.553f,0.553f, //34-37
				0.565f,0.565f, //38-39
				0.569f,0.569f,0.569f,0.569f,0.569f,0.569f,0.569f,0.569f,0.569f,0.569f, //40-49
				0.588f,0.588f,0.588f,0.588f,0.588f,0.588f,0.588f,0.588f,0.588f,0.588f, //50-59
				0.604f,0.604f,0.604f,0.604f,0.604f,0.604f,0.604f,0.604f,0.604f,0.604f, //60-69
				0.604f,0.604f,0.604f,0.604f,0.604f, //70-74
				0.613f,0.613f,0.613f,0.613f,0.613f, //75-79
				0.613f,0.613f,0.613f,0.613f,0.613f,0.613f,0.613f,0.613f,0.613f,0.613f, //80-89
				0.613f,0.613f,0.613f,0.613f,0.613f,0.613f,0.613f,0.613f,0.613f,0.613f, //90-99
				0.622f //100
            };

        static void Main(string[] args)
        {
            var reader = new StreamReader(File.OpenRead(@"C:\Users\Frienddo\Desktop\Mech3\MECH325\group-hw\a1-agma\nylon-only.csv"));
            var writer = new StreamWriter(File.OpenWrite(@"C:\Users\Frienddo\Desktop\Mech3\MECH325\group-hw\a1-agma\out.csv"));
            writer.WriteLine("PartNum_G_LS,maxAllowBendingStressIdeal_G_LS,workingFactor_G_LS,speedFactor_G_LS,temperatureFactor_G_LS,lubFactor_G_LS,matFactor_G_LS,maxAllowBendingStressReal_G_LS,PartNum_G_M,maxAllowBendingStressIdeal_G_M,workingFactor_G_M,speedFactor_G_M,temperatureFactor_G_M,lubFactor_G_M,matFactor_G_M,maxAllowBendingStressReal_G_M");

            reader.ReadLine(); //throw out first line of titles
            while (!reader.EndOfStream)
            {
                string[] pairVal = reader.ReadLine().Split(',');
                GearParams leadScrewGear = new GearParams(
                    pairVal[14], //PartNum_G_LS
                    float.Parse(pairVal[10]), //Torque_LS
                    rpm2radps(float.Parse(pairVal[11])), //RPM_LS
                    in2m(float.Parse(pairVal[17])), //PDiam_G_LS
                    in2m(float.Parse(pairVal[19])), //FW_G_LS
                    float.Parse(pairVal[21]), //NumTeeth_LS
                    in2m(float.Parse(pairVal[5])) //Lead_LS
                    );
                GearParams motorGear = new GearParams(
                    pairVal[15], //PartNum_G_M
                    float.Parse(pairVal[12]), //Torque_M
                    rpm2radps(float.Parse(pairVal[13])), //RPM_M
                    in2m(float.Parse(pairVal[18])), //PDiam_G_M
                    in2m(float.Parse(pairVal[20])), //FW_G_M
                    float.Parse(pairVal[22]), //NumTeeth_M
                    in2m(float.Parse(pairVal[5])) //Lead_LS
                    );
                string toWrite = leadScrewGear.id
                    + ',' + pa2psi(leadScrewGear.maxAllowBendingStressIdeal)
                    + ',' + leadScrewGear.workingFactor
                    + ',' + leadScrewGear.speedFactor  //unitless
                    + ',' + leadScrewGear.temperatureFactor  //unitless
                    + ',' + leadScrewGear.lubFactor  //haha lube //unitless
                    + ',' + leadScrewGear.matFactor  //unitless
                    + ',' + pa2psi(leadScrewGear.maxAllowBendingStressReal)
                    + ',' + motorGear.id
                    + ',' + pa2psi(motorGear.maxAllowBendingStressIdeal)
                    + ',' + motorGear.workingFactor
                    + ',' + motorGear.speedFactor  //unitless
                    + ',' + motorGear.temperatureFactor  //unitless
                    + ',' + motorGear.lubFactor  //haha lube //unitless
                    + ',' + motorGear.matFactor  //unitless
                    + ',' + pa2psi(motorGear.maxAllowBendingStressReal);
                writer.WriteLine(toWrite);
            }
        }

        private static float in2m(float v)
        {
            return v * 0.0254f; //1 inch = 0.0254 meters
        }

        private static float rpm2radps(float v)
        {
            return v * (float)Math.PI / 30f; //1 rpm = pi/30 radians per second (2 pi / 60)
        }

        private static float pa2psi(float v)
        {
            return v * 0.000145037738f;//1 pascal =0.000145037738 pounds per square inch
        }

        private class GearParams
        {
            public string id { get; set; }

            float torque; //Nm
            float angVel; //rad/s
            float pitchD; //m
            float faceW; //m
            float teethNum; //unitless
            float leadOfScrew; //m

            float tangentForce; //N
            float formFactor; //unitless
            float module; //m
            public float maxAllowBendingStressIdeal { get; set; } //Pa

            public float workingFactor { get; set; } //unitless
            public float speedFactor { get; set; } //unitless
            public float temperatureFactor { get; set; } //unitless
            public float lubFactor { get; set; } //haha lube //unitless
            public float matFactor { get; set; } //unitless
            public float maxAllowBendingStressReal { get; set; } //Pa

            public GearParams(string id, float torque, float angVel, float pitchD, float faceW, float teethNum, float leadOfScrew)
            {
                this.id = id;
                this.torque = torque;
                this.angVel = angVel;
                this.pitchD = pitchD;
                this.faceW = faceW;
                this.teethNum = teethNum;
                this.leadOfScrew = leadOfScrew;

                initVals();
            }

            private void initVals()
            {
                //ref: eq 18-1 of link, shigley's
                tangentForce = torque / (pitchD / 2);
                formFactor = formFactorTable[(int)teethNum];
                module = pitchD / teethNum;
                maxAllowBendingStressIdeal = tangentForce / (module * formFactor * faceW);

                //ref: table 18-3 of link
                //Each stroke is 10 cm in length,
                //used 40 times per day, 250 days per year, 
                //and is intended to last 4 years without maintenance
                //assume light impact from motor as worse case
                float verticalSpeed = leadOfScrew * angVel * 2f * (float)Math.PI; //m/s
                float timePerStroke = .1f / verticalSpeed; //s
                float averageTimePerDay = (timePerStroke * 40f * 250f / 365f) / 3600f; //hr 
                if (averageTimePerDay <= 0.5f)
                {
                    workingFactor = 0.8f;
                } else if (averageTimePerDay <= 3f)
                {
                    workingFactor = 1f;
                } else if (averageTimePerDay <= 10f)
                {
                    workingFactor = 1.25f;
                } else
                {
                    workingFactor = 1.50f;
                }

                //ref: table 18-2 of link
                // assume unlubricated since no maintenance
                float tangentialSpeed = angVel * pitchD / 2f; //m/s
                if (tangentialSpeed >= 5f)
                {
                    speedFactor = 0.7f;
                } else
                {
                    speedFactor = 1f;
                }

                //ref: fig 18-4
                //assume room temp (~25C)
                temperatureFactor = 0.95f;

                //ref: table 18-4
                //assume no maintenance
                lubFactor = 1f;

                //ref: table 18-5
                //2 plastic gears meshing
                matFactor = 0.75f;

                //ref: eq 18-2 of link
                maxAllowBendingStressReal = maxAllowBendingStressIdeal * speedFactor * temperatureFactor * lubFactor * matFactor / workingFactor;
            }
        }
    }
}
