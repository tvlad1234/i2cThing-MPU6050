#include "main.h"
#include "mpu6050.h"

float ax, ay, az, gx, gy, gz;
char sx[10], sy[10], sz[10];
uint8_t gyroOrAccel;

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

        if (!gyroOrAccel)
        {
            readAccel(&ax, &ay, &az);
            printFloat(ax, 1, sx);
            printFloat(ay, 1, sy);
            printFloat(az, 1, sz);
            printf("Accel in m/s^2\nX: %s Y: %s\nZ: %s\n", sx, sy, sz);
        }
        else
        {
            readGyro(&gx, &gy, &gz);
            printFloat(gx, 1, sx);
            printFloat(gy, 1, sy);
            printFloat(gz, 1, sz);
            printf("AngVel in deg/s\nX: %s Y: %s\nZ: %s\n", sx, sy, sz);
        }

        if (readButton())
        {
            gyroOrAccel = !gyroOrAccel;
            HAL_Delay(500);
        }

        flushDisplay();
        HAL_Delay(100);
    }
}