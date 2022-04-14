#include "main.h"
#include "mpu6050.h"

float ax, ay, az, gx, gy, gz;
uint8_t show;

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

        if (!show)
        {
            readAccel(&ax, &ay, &az);
            printf("Accel in m/s^2\nX: %.1f Y: %.1f\nZ: %.1f\n", ax, ay, az);
        }
        else
        {
            readGyro(&gx, &gy, &gz);
            printf("AngVel in deg/s\nX: %.1f Y: %.1f\nZ: %.1f\n", gx, gy, gz);
        }

        if (readButton())
        {
            show = !show;
            HAL_Delay(500);
        }

        flushDisplay();
        HAL_Delay(100);
    }
}