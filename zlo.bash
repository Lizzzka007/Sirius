#!/bin/bash
experiment_number=0
viscosity=5600
for ((i=1;i<4;i++))
    do
        ((cx=96 * ($i + 1) ))
        ((cy=64 * ($i + 1) ))
        ((cz=64 * ($i + 1) ))
        ((viscosity+=5600))
        for ((j=0;j<3;j++))
            do
                mkdir $experiment_number
                cp config-couette.txt nsenx run.sh pressure-init.nsx temperature-init.nsx velocity-init.nsx $experiment_number
                cd $experiment_number
                mkdir init
                cp pressure-init.nsx temperature-init.nsx  velocity-init.nsx init
                rm pressure-init.nsx temperature-init.nsx  velocity-init.nsx
                sed -i "s/cx = 96; cy = 64; cz = 64;/cx = $cx; cy = $cy; cz = $cz;/" config-couette.txt
                sed -i "s/viscosity = 1.0 \/ 5600.0;/viscosity = 1.0 \/ $viscosity.0;/" config-couette.txt
                sed -i "s/Richardson = 0.0;/Richardson = 0.0$j;/" config-couette.txt
                # sed -i "s/ntasks=64/ntasks=$1/" run.sh
                sbatch run.sh
                ((experiment_number+=1))
                # cat > info.txt
                # echo "viscosity = 1.0 \/ $i, Richardson = 0.0$j." > info.txt
                cd ../
            done
    done