public class MyQuickSort {
     
    private ArrayList<PVector> array;
    private int len;
    private PVector node;
 
    public void sort(ArrayList<PVector> inputArr, PVector nodeN) {
         
        if (inputArr == null || inputArr.size() == 0) {
            return;
        }
        this.node=nodeN;
        this.array = inputArr;
        len = inputArr.size()-1;
        quickSort(0, len - 1);
    }
 
    private void quickSort(int lowerIndex, int higherIndex) {
         
        int i = lowerIndex;
        int j = higherIndex;
        int middle =lowerIndex+(higherIndex-lowerIndex)/2;
        // calculate pivot number, I am taking pivot as middle index number
        float pivot = dist(array.get(middle).x,
                           array.get(middle).y,
                           array.get(middle).z,
                           node.x,node.y,node.z);
        // Divide into two arrays
        while (i <= j) {
            /**
             * In each iteration, we will identify a number from left side which 
             * is greater then the pivot value, and also we will identify a number 
             * from right side which is less then the pivot value. Once the search 
             * is done, then we exchange both numbers.
             */
            while (dist(array.get(i).x,
                        array.get(i).y,
                        array.get(i).z,
                        node.x,node.y,node.z) < pivot) {
                i++;
            }
            while (dist(array.get(j).x,
                        array.get(j).y,
                        array.get(j).z,
                        node.x,node.y,node.z) > pivot) {
                j--;
            }
            if (i <= j) {
                exchangeNumbers(i, j);
                //move index to next position on both sides
                i++;
                j--;
            }
        }
        // call quickSort() method recursively
        if (lowerIndex < j)
            quickSort(lowerIndex, j);
        if (i < higherIndex)
            quickSort(i, higherIndex);
    }
 
    private void exchangeNumbers(int i, int j) {
        PVector temp = new PVector(array.get(i).x,   array.get(i).y,         array.get(i).z);  
        array.set(i, array.get(j));
        array.set(j, temp);
        
        
        
        //array.set(j) = temp;
    }
    
}