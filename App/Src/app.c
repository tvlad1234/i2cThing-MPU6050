#include "main.h"
#include "mpu6050.h"

#define DPS_TO_RADS (0.017453293F)

float x, y, z;
char sx[10], sy[10], sz[10];
uint8_t showGyro;

int main(void)
{
    thingInit();

    if (!mpuBegin(thingPort()))
    {
        printf("MPU6050 error!\n");
        flushDisplay();
        Error_Handler();
    }
    else
    {
        printf("MPU6050 OK!\n");
        flushDisplay();
        HAL_Delay(1000);
    }

    while (1)
    {
        clearDisplay();
        setCursor(0, 0);

        if (!showGyro)
        {
            readMPUAccel(&x, &y, &z);
            printFloat(x, 1, sx);
            printFloat(y, 1, sy);
            printFloat(z, 1, sz);
            printf("Accel in m/s^2\nX: %s Y: %s\nZ: %s\n", sx, sy, sz);
        }
        else
        {
            readMPUGyro(&x, &y, &z);
            printFloat(x * DPS_TO_RADS, 1, sx);
            printFloat(y * DPS_TO_RADS, 1, sy);
            printFloat(z * DPS_TO_RADS, 1, sz);
            printf("AngVel in rad/s\nX: %s Y: %s\nZ: %s\n", sx, sy, sz);
        }

        if (readButton())
        {
            showGyro = !showGyro;
            HAL_Delay(500);
        }

        flushDisplay();
        HAL_Delay(50);
    }
}